class ApiConstant {
  static const String baseUrl = 'https://next-step-api.onrender.com';

  // Authentication
  static const String loginEp = '/api/v2/auth/login';
  static const String registerEp = '/api/v2/auth/register';
  static const String getAuthauthenticatedUserEp = '/api/v2/auth/me';
  static const String updataUserProfileEP = '/api/v2/auth/update';
  static const String patchUserProfileEP = '/api/v2/auth/patch';
  static const String checkProfileStatusEP = '/api/v2/auth/profile-status';

  // Jobs
  static const String createJobEp = '/api/v2/job/create';
  static String updateJobEp(String id) => '/api/v2/job/update/$id';
  static String patchJobEp(String id) => '/api/v2/job/patch/$id';
  static String deleteJobEp(String id) => '/api/v2/job/delete/$id';
  static const String getUserJobsEp = '/api/v2/job/me';
  static const String listJobsEp = '/api/v2/job/all';
  static String getJobBySlugEp(String slug) => '/api/v2/job/detail/$slug';
  static String getJobByIdEp(String id) => '/api/v2/job/$id';

  // Applications
  static const String createApplicationEp = '/api/v2/application/create';
  static String patchApplicationStatusEp(String applicationId) =>
      '/api/v2/application/patch/$applicationId';
  static String deleteApplicationEp(String applicationId) =>
      '/api/v2/application/delete/$applicationId';
  static const String getUserApplicationsEp = '/api/v2/application/user';
  static String getJobApplicationsEp(String jobId) =>
      '/api/v2/application/job/$jobId';
  static const String batchDeleteUserApplicationsEp =
      '/api/v2/application/batch-delete';

  // Favorites
  static const String addFavoriteJobEp = '/api/v2/favorite/add';
  static String removeFavoriteJobEp(String jobId) =>
      '/api/v2/favorite/remove/$jobId';
  static const String listUserFavoritesEp = '/api/v2/favorite/all';
  static const String batchDeleteUserFavoritesEp =
      '/api/v2/favorite/batch-delete';

  // Statistics
  static const String getPlatformStatsEp = '/api/v2/stats';

  // Categories
  static const String createCategoryEp = '/api/v2/category/create';
  static String updateCategoryEp(String id) => '/api/v2/category/update/$id';
  static String deleteCategoryEp(String id) => '/api/v2/category/delete/$id';
  static const String listCategoriesEp = '/api/v2/category/all';
}
