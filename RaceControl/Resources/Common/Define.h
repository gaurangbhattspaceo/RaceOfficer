//
//  Define.h
//  Deckopedia
//

#define APP_NAME                @"RaceControl"

#define APP_StoreURL                @"http://www.google.com"

#define WIDTH_MSCREEN       [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_MSCREEN      [[UIScreen mainScreen] bounds].size.height

#define kAccount                   @"Account"
#define kUserEmail                 @"UserEmail"
#define kUserPassword              @"UserPassword"


  //  #define API_SERVER_ROOT_URL    @"http://192.168.1.100/apps/frimb/web"
    #define API_SERVER_ROOT_URL    @"http://www.peerdevelopment.com/apps/frimb/web"


//---------------------------------------------------+6------------------


#define kFormatDateTimeUTC          @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"
#define kFormatDateServer           @"yyyy-MM-dd HH:mm:ss"
#define kFormatDateUI               @"dd-MM-yyyy HH:mm:ss"
#define kFormatDateNottimeServer    @"dd-MM-yyyy"


//-------------------------------------------------------

//-------------------------------------------------------
#define kFontHelveticaRegular       @"Helvetica"

//-----------------------------------------------


// Invite Twitter
#define kconsumerKey                @""
#define kconsumerSecrect            @""
#define kOauthTokent_Twitter        @"Twitter_accessTokent"
#define kAllowAccess                @"Allow_Access"


//--------------------------------------------------------
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define CLog(fmt, ...) printf("%s\n", [fmtStr(fmt, ##__VA_ARGS__) cStringUsingEncoding:NSASCIIStringEncoding])
#else
#define DLog(...)
#define CLog(...)
#endif

//--------------------------------------------------------


//Font--------------------------------------------------------
#define kFontTitleSize                          [UIFont fontWithName: @"Helvetica" size:17]


#define pinterest_Client_Id  @"1443864"//@"1436918"
#define pinterest_sourceURL  @"http://peerbits.com"

//Alert--------------------------------------------------------

//Title
#define Alert_Title                             @"541GO Race Officer"

//Request API
#define Alert_DataError                         @"Data error!"
#define Alert_ServerError                       @"Server error!"
#define Alert_CannotConnectServer               @"Can't connect to server"
#define Alert_NoInternet                        @"Unable to connect with the server. Check your internet connection and try again."

#define Alert_SometingWrong                     @"Something went wrong please try again."

// Home

#define Alert_Report_Sucess                     @"Recipe reported successfully."
#define Alert_Suggestion_Sucess                 @"Thank you for your suggestion."
#define Alert_alreadyReported                   @"This recipe is already reported by you."


//Sign In, Sign Up
#define Alert_Fullname_Empty                    @"Please enter full name."
#define Alert_FullnameLimit                     @"Fullname must be at least 6 char long."
#define Alert_Username_Empty                    @"Username cannot be blank"
#define Alert_EmailValidate                     @"Email already exists. Please try again."
#define Alert_PasswordValidate                  @"Password and confirm password do not match."
#define Alert_FieldsAreMissing                  @"Information was missing."
#define Alert_OldPassword_Empty                    @"Please enter an old password."
#define Alert_Password_Empty                    @"Please enter password."
#define Alert_ConfirmPassword_Empty             @"Please enter confirm password."
#define Alert_PasswordLimit                     @"Password must be at least 6 char long."
#define Alert_UsernameLimit                     @"Username must be at least 6 char long."
#define Alert_FieldsSpaceBar                    @"cannot contain white space."
#define Alert_PasswordIncorrect                 @"Please enter valid password."
#define Alert_PasswordNotMatch                  @"Password and confirm password do not match."
#define Alert_Email_Empty                       @"Please enter email address."
#define Alert_EmailInvalid                      @"Please enter valid email address."
#define Alert_ForgotPasswordSuccessful          @"Password has been sent to your registered email address."
#define Alert_UsernameOrEmail_Empty             @"Username or email cannot be blank"

#define Alert_NotValidSignUp                    @"You have to follow minimum three user to continue."

//Profile
#define Alert_FieldsLimit                       @"must be at least 6 characters."
#define Alert_SaveProfileSuccess                @"Save profile successfully"
#define Alert_UpdateProfileSuccess              @"Profile updated successfully"
#define Alert_ChangePasswordSuccess             @"Change password successfully"
#define Alert_ProfileNoChange                   @"Profile information aren't change"

#define Alert_DeleteAccount             @"Do you really want to delete your account?"

#define Alert_CannotDelete                    @"You are uploading Recipe/Food image.You cannot delete account from application right now."


#define Alert_Logout                    @"Are you sure want to logout?"

#define Alert_CannotLogout                    @"You are uploading Recipe/Food image.You cannot log out from application right now."

#define Alert_ReportOrSuggestion             @"Please enter some text."

#define Alert_ChooseProfileImage               @"Select your image source type"
#define Alert_SettingChanged                   @"App Settings are changed successfully."

#define Alert_ZeroPostsUser                        @"There are no recipe/food image posted by user."

#define Alert_ZeroPostsSelf                        @"There are no recipe/food image posted by you."

#define Alert_ZeroFavoriteUser                        @"There are no favorite recipe/food image of this user."

#define Alert_ZeroFavoriteSelf                        @"There are no favorite recipe/food image of you."

#define Alert_NameMissing                           @"Please enter name."
#define Alert_NameShouldContainsAlphabets           @"Name should contains alphabets only."
#define Alert_EmailMissing                          @"Please enter email."
#define Alert_ContactMissing                        @"Please enter contact."
#define Alert_invalidBlog                           @"Please enter valid blog url."

#define Alert_PartnerSucess                        @"Thank You for your interest.\nWe will contact you soon."

#define Alert_UserHaveZeroPost                        @"No posts yet."

#define Alert_OtherUserHaveZeroPost                        @"This user have not post any Recipe/Food Image yet."

// Camera

#define Alert_NoCamera                                  @"No Camera Detected"
#define Alert_RecipeNameBlank                           @"Please enter recipe name."
#define Alert_DeleteMediaImage                          @"Do you really want to delete this image?"
#define Alert_DeleteMediaVideo                          @"Do you really want to delete this video?"

#define msgNoImageSelected                               @"No image/video selected."

#define lastPostRecipe                                   @"lastPostRecipe"
#define lastPostFood                                     @"lastPostFood"

// Share Settings

#define link_FB                                 @"facebookData"
#define link_TW                                 @"twitterData"
#define link_PT                                 @"pintrestData"
#define link_TL                                 @"tumblrkData"


#define alert_linkTumblerFailed                 @"Linking with tumblr failed."

#define alert_linkTumblerSuccess                @"Tumblr linked successfully."

#define alert_FollowNotSelected                 @"Follow@frimb should not off."

#define Alert_ShareSucess                     @"Post shared successfully"
#define Alert_userNameAndPasswordEmpty        @"User name and password can not blank"

#define pintrestClientId                        @"1443864"
#define pintrestUrlSuffix                       @"pinUser"

 //Peerbits A/C
/*
#define tumblrAuthKey                           @"384AbqubEnONXgOLKIlMXGeqW1geA6hM8ydB54A0QhMATk8lbJ"
#define tumblrSecreatKey                           @"O6Sf8faZc7GGUm0ZSl0xIuntaQ09AePCfw0ymg92mLqQsEUqEr"
#define tumblrTokenKey                           @"OThBSma3aqWJjVSCHGo1jvZPasIJchxHlD8meav0Vz5GSFEAYC"
#define tumblrTokenSecreatKey                           @"b77l1le0FKatt7weSa4LEmrJ0JQLoZIKGfdFyx21Gst0zX2uOe"
 */


// Client's A/C
#define tumblrAuthKey                           @"hZUKbGoT1PLWsx04EDVL5MtUw9oZTDCrSLGGyO69VNYAJccGAz"
#define tumblrSecreatKey                           @"GvZl66wxfUuM3dO6jAajx0vNzg4uJBf1jgaJ2urbQftOK7U0dk"
#define tumblrTokenKey                           @"899RkGyxZtuwV8GTBoZN5paL3EZ6US6L7Qr50tWIBAx2IOQCgZ"
#define tumblrTokenSecreatKey                           @"C6Eyz9d07YRiPAGuJY5nEENfciK1MRcjQc9vuETefFVjugXOmN"

//Button
#define Button_YES                              @"YES"
#define Button_NO                               @"NO"
#define Button_OK                               @"OK"
#define Button_Cancel                           @"Cancel"
#define Button_View                             @"View"
#define Button_Back                             @"Back"
#define Button_Camera                           @"Camera"
#define Button_PhotoLibrary                     @"Photo Library"
#define Button_Retry                            @"Retry"
#define Button_UnFollow                         @"Unfollow"
