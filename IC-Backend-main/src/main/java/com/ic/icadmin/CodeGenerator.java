package com.ic.icadmin;
//package com.ic.icadmin;
//
//import com.baomidou.mybatisplus.annotation.DbType;
//import com.baomidou.mybatisplus.annotation.IdType;
//import com.baomidou.mybatisplus.generator.AutoGenerator;
//import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
//import com.baomidou.mybatisplus.generator.config.GlobalConfig;
//import com.baomidou.mybatisplus.generator.config.PackageConfig;
//import com.baomidou.mybatisplus.generator.config.StrategyConfig;
//import com.baomidou.mybatisplus.generator.config.rules.DateType;
//import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
//
//import org.junit.Test;
//
//public class CodeGenerator {
//    @Test
//    public void main1() {
//
//        // 1、创建代码生成器
//        AutoGenerator mpg = new AutoGenerator();
//
//        // 2、全局配置
//        GlobalConfig gc = new GlobalConfig();
//        gc.setOutputDir("/Users/mlamp/workspace/file/lf/code/ic-admin-backend/src/main/java");
//        gc.setAuthor("ljc");
//        gc.setOpen(false); //生成后是否打开资源管理器
//        gc.setFileOverride(false); //重新生成时文件是否覆盖
//        /*
//         * mp生成service层代码，默认接口名称第一个字母有 I
//         * UcenterService
//         * */
//        gc.setServiceName("%sService");    //去掉Service接口的首字母I
//        gc.setIdType(IdType.AUTO); //主键策略
//        gc.setDateType(DateType.ONLY_DATE);//定义生成的实体类中日期类型
//        gc.setSwagger2(true);//开启Swagger2模式
//
//        mpg.setGlobalConfig(gc);
//        // 3、数据源配置
//        DataSourceConfig dsc = new DataSourceConfig();
//        dsc.setUrl("jdbc:postgresql://47.242.234.185:5432/beaver_api_staging");
//        dsc.setDriverName("org.postgresql.Driver");
//        dsc.setUsername("deploy");
//        dsc.setPassword("welcome2018");
//        dsc.setDbType(DbType.POSTGRE_SQL);
//        mpg.setDataSource(dsc);
//
//        // 4、包配置
//        PackageConfig pc = new PackageConfig();
//        pc.setParent("com.ic.icadmin");
//        pc.setModuleName(""); //模块名
//        pc.setController("controller");
//        pc.setEntity("entity");
//        pc.setService("service");
//        pc.setMapper("mapper");
//        mpg.setPackageInfo(pc);
//
//        // 5、策略配置
//        StrategyConfig strategy = new StrategyConfig();
////        strategy.setInclude("pay");
//        strategy.setNaming(NamingStrategy.underline_to_camel);//数据库表映射到实体的命名策略
//        strategy.setTablePrefix(pc.getModuleName() + "_"); //生成实体时去掉表前缀
//
//        strategy.setColumnNaming(NamingStrategy.underline_to_camel);//数据库表字段映射到实体的命名策略
//        strategy.setEntityLombokModel(true); // lombok 模型 @Accessors(chain = true) setter链式操作
//
//        strategy.setRestControllerStyle(true); //restful api风格控制器
//        strategy.setControllerMappingHyphenStyle(true); //url中驼峰转连字符
//        strategy.setInclude("borrow_proposed_security");
//        mpg.setStrategy(strategy);
//
//        // 6、执行
//        mpg.execute();
//    }
//}
