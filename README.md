# Backend Configuration for ic Admin

This README provides instructions to set up and configure the backend for the BHG Admin application.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) - Make sure Docker is installed on your machine.

## Setup Instructions

### 1. Install Docker

If Docker is not already installed, download and install it from the official [Docker website](https://docs.docker.com/get-docker/). Follow the instructions for your operating system.

### 2. Run Docker Compose

In the project directory, run the following command to start the required services, make sure you have the docker-compose.yml file under project folder (e.g., PostgreSQL and any other services defined in your `docker-compose.yml` file):

```bash
docker-compose up
```

### Configure Nacos and Load Initial Data into PostgreSQL

Once the required services are up and running, follow these steps to configure Nacos and load the initial data into PostgreSQL.

#### Configure Nacos

1. Open a web browser and go to the Nacos configuration page:
   - [http://localhost:8848/nacos/](http://localhost:8848/nacos/)

2. Log in to Nacos if prompted.
3. Create a new configuration file in Nacos with the following content:

   ```yaml
        <!-- bhg-stage2-test-static-dev.yaml -->
       # springboot整合postgres连接配制
        spring:
          datasource:
            url: jdbc:postgresql://localhost:5434/postgres
            username: postgres
            password: example
            driver-class-name: org.postgresql.Driver
          redis:
            host: localhost
            database: 1
            port: 6379
            # password: Beaverasdf1234
            timeout: 5000
            lettuce:
              pool:
                max-active: 120
                max-idle: 120
                max-wait: 1200
                min-idle: 120
              shutdown-timeout: 5000
          # 设置-1，不限制导入文件的大小
          servlet: 
            multipart: 
              enabled: true
              max-file-size: 931775308
              max-request-size: 1000MB
          # freemarker:
          #   checkTemplateLocation: false
        
        mybatis-plus:
          configuration:
            mapUnderscoreToCamelCase: true
            auto-mapping-behavior: full
            # log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
          mapper-locations: classpath:/mapper/**/*.xml
          global-config:
            # 逻辑删除配置
            db-config:
              # 删除前
              logic-not-delete-value: 1
              # 删除后
              logic-delete-value: 0
          freemarker: 
            check-template-location: false
        
        static-properties:
          # Mailjet公钥和密钥
          MAILJET_API_KEY: 5cdfc1c60bc044568b2988b0982fc01c
          MAILJET_SECRET_KEY: 9ecbec77676c14091537e37923cfd8a8
          # EncryptUtil 密钥
          encryptKey: BeaverAdmin2022
          # RECAPTCHA2 公钥和密钥
          RECAPTCHA2_SITE_KEY: 6Le_MuYoAAAAAF-6M-R1ZQ9zwk6hqq0jJwGYVe0b
          RECAPTCHA2_SECRET_KEY: 6Le_MuYoAAAAAEL22RzWcjjfEAxEUagCsZUl_1WX
          # client默认密码
          clientDefaultPassword: asdf1234
          # 阿里云短信
          # MSG_ACCESSKEY_ID: LTAI5tRF6kfEqXFnjiHtYhwE
          # MSG_ACCESSKEY_SECRET: I5GCcwXjLwm4CNWcEq9loHogskJhMw
          MSG_ACCESSKEY_ID: LTAI5t83C7oekc7Kbr6x5H3X
          MSG_ACCESSKEY_SECRET: aGBiy4gmwWSEHCbB1aiojedUNMO2uT
          MSG_REGION: dysmsapi.ap-southeast-1.aliyuncs.com
          #oss配置
          oss:
            endpoint: oss-ap-southeast-1.aliyuncs.com
            accessKeyId: LTAI5tCmx8qnwPVX4vtmcgHY
            accessKeySecret: EwHMhb8xFj8J4NmK9AFkwgA2qn3K9Y
            bucketName: bhg-stage2
          # Kyc Truiloo账号密码
          trulioo_username: Beaver_Consulting_Trial_DocV_API
          trulioo_password: Welcome2022!
        
        #pageHelper
        pagehelper: 
          helperDialect: postgresql
          reasonable: true
          supportMethodsArguments: true
        template:
          path: /Users/xiaohu/Desktop/work/new
          
          
        <!-- new-bhg-admin-dynamic-prod.yaml -->
        dynamic-properties: 
          # token过期时间 60*60*24000*7 毫秒millisecond
          tokenExpireTime: 604800000
          # reset password token/code过期时间 1000*60*15
          resetPasswordTokenExpireTime: 900000
          # kyc回调接口
          kycCallBackUrl: https://bhgadmin.bhgglobal.com.au/api/v1/account/kyc-callBack
          # send unit certificate 邮件抄送和加密抄送人
          sendUCEmailReceivers:
            cc:
              - name: operations Mailbox
                email: operations@bhgglobal.com.au
            bcc:
              - name: Andy Chen
                email: andy.chen@bhgglobal.com.au
              - name: Emily Zhang
                email: emily.zhang@bhgglobal.com.au
          sendPFMonthlyEmailReceivers:
            cc:
              - name: operations
                email: operations@bhgglobal.com.au
          sendPFAnnualEmailReceivers:
            cc:
              - name: operations
                email: operations@bhgglobal.com.au
          sendEnquiryEmailReceivers:
            cc:
              - name: loan
                email: loan@bhgglobal.com.au
          sendInvestmentEmailReceivers:
            cc:
              - name: operations
                email: operations@bhgglobal.com.au
        passwordresetemail:
          subject: "Reset Beaver admin password"
          textPart: ""
          htmlPart: "<h3>Dear Admin, click <a href=\"http://8.219.111.81/#/login?type=reset&pwdResetToken={passwordResetToken}\">here</a> to reset password</h3>"
        
        knife4j:
          enable: true
          # 开启屏蔽文档资源
          production: false
        
        #sl4fj配置
        logging:
          file:
            name: new-beaver-admin
          config: classpath:logback-spring.xml
          level:
            root: info
          
    ```
    
##### Load Initial Data into PostgreSQL

Check the PostgreSQL database first, if there is no data in it, do the following.

To set up the database schema and initial data in PostgreSQL, follow these steps:

### 1. Load the Schema

Run the following command to create the necessary tables and database structures as defined in `schema.sql`:

```bash
psql -h localhost -p 5434 -U postgres -d postgres -f schema.sql
psql -h localhost -p 5434 -U postgres -d postgres -f data.sql
pg_restore -h localhost -p 5434 -U postgres -d postgres -v ./icdb.backup
```

# ic-Front End

This template should help get you started developing with Vue 3 in Vite.

## Recommended IDE Setup

[VSCode](https://code.visualstudio.com/) + [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) (and disable Vetur) + [TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin).

## Type Support for `.vue` Imports in TS

TypeScript cannot handle type information for `.vue` imports by default, so we replace the `tsc` CLI with `vue-tsc` for type checking. In editors, we need [TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin) to make the TypeScript language service aware of `.vue` types.

If the standalone TypeScript plugin doesn't feel fast enough to you, Volar has also implemented a [Take Over Mode](https://github.com/johnsoncodehk/volar/discussions/471#discussioncomment-1361669) that is more performant. You can enable it by the following steps:

1. Disable the built-in TypeScript Extension
    1) Run `Extensions: Show Built-in Extensions` from VSCode's command palette
    2) Find `TypeScript and JavaScript Language Features`, right click and select `Disable (Workspace)`
2. Reload the VSCode window by running `Developer: Reload Window` from the command palette.

## Customize configuration

See [Vite Configuration Reference](https://vitejs.dev/config/).

## Project Setup

```sh
npm install
```

### Compile and Hot-Reload for Development

```sh
npm run dev
```

### Type-Check, Compile and Minify for Production

```sh
npm run build
```

### Lint with [ESLint](https://eslint.org/)

```sh
npm run lint
```
