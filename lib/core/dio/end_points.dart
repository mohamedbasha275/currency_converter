
/// Enum representing all API endpoints.
enum Endpoint {
  // Main
  getSliders('main/slides'),
  //
  getCategories('categories'),
  getCategoryStores('categories'),
  getStores('stores'),
  getStoreInfo('stores'),
  getStoreOffers('stores'),
  getOffersFilter('offers'),
  getFavourites('subscriptions/others'),
  // countries
  getCountries('localization/countries'),
  // languages
  getLanguages('localization/languages'),
  // add store to favourite
  addFavouriteStore('subscriptions/stores'),
  removeFavouriteStore('subscriptions'),
  // add coupon to favourite
  addFavouriteOffer('subscriptions/offers'),
  removeFavouriteOffer('subscriptions'),
  addOfferFeedback('offers'),
  //
  // explore
  getFeaturedOffers('offers/featured'),
  getLimitedTimeOffers('offers/expiring-soon'),
  //
  getCouponsDetails('offers'),
  // User
  getCurrentUser('user/profile'),
  updateCurrentUser('user/profile'),
  changeCountry('user/locale/change-country'),
  changeLanguage('user/locale/change-language'),
  
  // Notifications
  getNotifications('notifications'),
  markNotificationRead('notifications/read'),
  deleteNotification('notifications/delete'),
  clearAllNotifications('notifications/clear'),

  // Authentication
  login('auth/login'),
  socialLogin('auth/social-login'),
  guestLogin('auth/register-guest'),
  // register
  register('user/upgrade-account'),
  registerOtp('user/upgrade-account/verify-otp'),
  //
  // forget pass
  forgetPassword('auth/forgot-password'),
  forgetPasswordOtp('auth/verify-otp'),
  resetPassword('auth/reset-password'),
  //
  logout('auth/logout'),
  //
  getInterests('categories'),
  saveInterests('subscriptions/bulk-subscribe-categories'),
  getCategoriesSubscriptions('subscriptions');




  /// The string value of the endpoint.
  final String path;
  const Endpoint(this.path);
}

extension EndpointExtension on Endpoint {
  /// Returns the string path of the endpoint.
  String get value => path;
}