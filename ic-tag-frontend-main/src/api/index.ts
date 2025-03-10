import { userApi } from './user/user'
import { dashboardApi } from './dashboard/dashboard'
import { adminApi } from './admin/admin'
import { enquiryApi } from './enquiry/enquiry'
import { eventApi } from './event/event'
import { dictApi } from './dict/dict'
import { fundApi } from './fund/fund'
import { clientApi } from './client/client'
import { entityApi } from './client/entity'
import { referralApi } from './referral/referral'
import { notificationApi } from './notification/notification'
import { auditApi } from './audit/audit'
import { investmentApi } from './investment/investment'
import { tagApi } from './tag/tag'

export const api = {
  ...userApi,
  ...dashboardApi,
  ...adminApi,
  ...enquiryApi,
  ...eventApi,
  ...dictApi,
  ...fundApi,
  ...clientApi,
  ...referralApi,
  ...notificationApi,
  ...auditApi,
  ...investmentApi,
  ...entityApi,
  ...tagApi
}
