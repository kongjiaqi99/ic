const permissionsList = [
  {
    name: 'Dashboard',
    read: ['superAdmin', 'fundAdmin', 'fundOperation'],
    white: ['superAdmin', 'fundAdmin', 'fundOperation']
  },
  {
    name: 'Client',
    read: ['superAdmin', 'fundAdmin', 'fundOperation'],
    white: ['superAdmin', 'fundAdmin']
  },
  {
    name: 'Fund',
    read: ['superAdmin', 'fundAdmin', 'fundOperation'],
    white: ['superAdmin', 'fundAdmin']
  },
  {
    name: 'Investment',
    read: ['superAdmin', 'fundAdmin', 'fundOperation'],
    white: ['superAdmin', 'fundAdmin']
  },
  {
    name: 'Referral',
    read: ['superAdmin'],
    white: ['superAdmin']
  },
  {
    name: 'Enquiry',
    read: ['superAdmin', 'fundAdmin', 'fundOperation', 'webAdmin'],
    white: ['superAdmin', 'fundAdmin', 'fundOperation', 'webAdmin']
  },
  {
    name: 'Event',
    read: ['superAdmin', 'fundAdmin', 'fundOperation', 'webAdmin'],
    white: ['superAdmin', 'fundAdmin', 'webAdmin']
  },
  {
    name: 'Audit',
    read: ['superAdmin', 'fundAdmin', 'fundOperation'],
    white: ['superAdmin', 'fundAdmin']
  },
  {
    name: 'Notification',
    read: ['superAdmin', 'fundAdmin', 'fundOperation', 'webAdmin'],
    white: ['superAdmin', 'fundAdmin', 'fundOperation', 'webAdmin']
  },
  {
    name: 'Admin',
    read: ['superAdmin'],
    white: ['superAdmin']
  }
]

export { permissionsList }
