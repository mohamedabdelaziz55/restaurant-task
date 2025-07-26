class ApiConstants {
  // Base URL
  // static const String baseUrl = 'http://10.0.2.2/php_makany';
  static const String baseUrl = 'http://192.168.1.112/php_makany';

  // Authentication Endpoints
  static const String login = '$baseUrl/auth/login.php';
  static const String register = '$baseUrl/auth/register';
  // static const String forgotPassword = '$baseUrl/auth/forgot-password';
  // static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String logout = '$baseUrl/auth/logout';
  static const String refreshToken = '$baseUrl/auth/refresh-token';
  
  // User Endpoints
  static const String users = '$baseUrl/users';
  static const String userProfile = '$baseUrl/users/profile';
  static const String userActivity = '$baseUrl/users/activity';
  static const String userDevices = '$baseUrl/users/devices';
  
  // Product Endpoints
  static const String products = '$baseUrl/products';
  static const String categories = '$baseUrl/categories';
  static const String suppliers = '$baseUrl/suppliers';
  static const String colors = '$baseUrl/colors';
  static const String sizes = '$baseUrl/sizes';
  
  // Order Endpoints
  static const String orders = '$baseUrl/orders';
  static const String orderStatuses = '$baseUrl/orders/statuses';
  static const String orderRejectReasons = '$baseUrl/orders/reject-reasons';
  static const String orderWaitReasons = '$baseUrl/orders/wait-reasons';
  
  // Inventory Endpoints
  static const String inventory = '$baseUrl/inventory';
  static const String inventoryMovements = '$baseUrl/inventory/movements';
  static const String inventoryAlerts = '$baseUrl/inventory/alerts';
  
  // Accounting Endpoints
  static const String transactions = '$baseUrl/accounting/transactions';
  static const String expenses = '$baseUrl/accounting/expenses';
  static const String revenues = '$baseUrl/accounting/revenues';
  static const String financialReports = '$baseUrl/accounting/reports';
  
  // Shipping Endpoints
  static const String governorates = '$baseUrl/governorates';
  static const String shippingCompanies = '$baseUrl/shipping-companies';
  static const String shippingRates = '$baseUrl/shipping-rates';
  
  // Marketing Endpoints
  static const String facebookPages = '$baseUrl/marketing/facebook-pages';
  static const String marketingCampaigns = '$baseUrl/marketing/campaigns';
  static const String marketingPosts = '$baseUrl/marketing/posts';
  static const String marketingComments = '$baseUrl/marketing/comments';
  static const String marketingMessages = '$baseUrl/marketing/messages';
  
  // Settings Endpoints
  static const String settings = '$baseUrl/settings';
  static const String companySettings = '$baseUrl/settings/company';
  static const String securitySettings = '$baseUrl/settings/security';
}

class AppConstants {
  // App Information
  static const String appName = 'تطبيق إدارة المبيعات';
  static const String appVersion = '1.0.0';
  
  // Shared Preferences Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';
  static const String firstRunKey = 'first_run';
  
  // Default Settings
  static const String defaultLanguage = 'ar';
  static const bool defaultDarkMode = false;
  
  // Pagination
  static const int defaultPageSize = 20;
  
  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // File Upload
  static const int maxImageSize = 5 * 1024 * 1024; // 5 MB
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png', 'webp'];
  
  // Order Status
  static const String orderStatusNew = 'new';
  static const String orderStatusConfirmed = 'confirmed';
  static const String orderStatusPreparing = 'preparing';
  static const String orderStatusShipped = 'shipped';
  static const String orderStatusDelivered = 'delivered';
  static const String orderStatusCancelled = 'cancelled';
  static const String orderStatusReturned = 'returned';
  static const String orderStatusWaiting = 'waiting';
  static const String orderStatusRejected = 'rejected';
  
  // User Roles
  static const String roleAdmin = 'admin';
  static const String roleTeamLeader = 'team_leader';
  static const String roleEmployee = 'employee';
  static const String roleConfirm = 'confirm';
  static const String roleInventory = 'inventory';
  static const String roleMarketing = 'marketing';
  
  // Activity Types
  static const String activityLogin = 'login';
  static const String activityLogout = 'logout';
  static const String activityCreateOrder = 'create_order';
  static const String activityUpdateOrder = 'update_order';
  static const String activityCreateProduct = 'create_product';
  static const String activityUpdateProduct = 'update_product';
  static const String activityCreateUser = 'create_user';
  static const String activityUpdateUser = 'update_user';
  
  // Error Messages
  static const String errorNetworkMessage = 'لا يمكن الاتصال بالخادم، يرجى التحقق من اتصالك بالإنترنت';
  static const String errorServerMessage = 'حدث خطأ في الخادم، يرجى المحاولة مرة أخرى لاحقاً';
  static const String errorUnauthorizedMessage = 'انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى';
  static const String errorValidationMessage = 'يرجى التحقق من صحة البيانات المدخلة';
  static const String errorUnknownMessage = 'حدث خطأ غير معروف، يرجى المحاولة مرة أخرى';
}

class AppRoutes {
  // Authentication Routes
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  
  // Admin Routes
  static const String adminDashboard = '/admin/dashboard';
  static const String adminUsers = '/admin/users';
  static const String adminProducts = '/admin/products';
  static const String adminOrders = '/admin/orders';
  static const String adminInventory = '/admin/inventory';
  static const String adminAccounting = '/admin/accounting';
  static const String adminMarketing = '/admin/marketing';
  static const String adminSettings = '/admin/settings';
  static const String adminActivityLogs = '/admin/activity-logs';
  
  // Team Leader Routes
  static const String teamLeaderDashboard = '/team-leader/dashboard';
  static const String teamLeaderTeam = '/team-leader/team';
  static const String teamLeaderOrders = '/team-leader/orders';
  static const String teamLeaderReports = '/team-leader/reports';
  
  // Employee Routes
  static const String employeeDashboard = '/employee/dashboard';
  static const String employeeOrders = '/employee/orders';
  static const String employeeProducts = '/employee/products';
  static const String employeeCustomers = '/employee/customers';
  
  // Confirm Routes
  static const String confirmDashboard = '/confirm/dashboard';
  static const String confirmOrders = '/confirm/orders';
  static const String confirmReports = '/confirm/reports';
  
  // Inventory Routes
  static const String inventoryDashboard = '/inventory/dashboard';
  static const String inventoryStock = '/inventory/stock';
  static const String inventoryMovements = '/inventory/movements';
  static const String inventoryReports = '/inventory/reports';
  
  // Marketing Routes
  static const String marketingDashboard = '/marketing/dashboard';
  static const String marketingPages = '/marketing/pages';
  static const String marketingCampaigns = '/marketing/campaigns';
  static const String marketingPosts = '/marketing/posts';
  static const String marketingComments = '/marketing/comments';
  static const String marketingMessages = '/marketing/messages';
  
  // Common Routes
  static const String profile = '/profile';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String help = '/help';
}
