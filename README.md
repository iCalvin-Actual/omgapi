# api.lol

A description of this package.

struct UrlConstructor {
    private let base = "https://api.omg.lol/"
    private var baseURL: URL? {
        URL(string: base)
    }
    
    private let account = "account/{email}/info/"
/*
 GET
 Auth: YES
 Body: None
 Response: [
     message: String?
     email: String
     created: TimeStamp
     settings: AccountSettings
] 
*/
    
    private let addresses = "account/{email}/addresses/"
/*
 GET
 Auth: YES
 Body: None
 Response: [
     AccountAddress, AccountAddress, ...
 ] 
*/
    
    private let accountName = "account/{email}/name/"
/*
 GET
 Auth: YES
 Body: None
 Response: AccountOwner
 
 POST
 Auth: YES
 Body: [
   name: String
 ]
 Response: AccountOwner
*/
    
    private let accountSessions = "account/{email}/sessions/"
/*
 GET
 Auth: YES
 Body: None
 Response: [
   ActiveSession, ActiveSession, ...
 ]
*/
    
    private let deleteSession = "account/{email}/sessions/{sessionId}"
/*
 DELETE
 Auth: Yes
 Body: None
 Response: BasicResponse
*/
    
    private let accountSettings = "account/{email}/settings"
/*
 GET
 Auth: Yes
 Body: None
 Response: [
   message: String?
   settings: AccountSettings
 
 POST
 Auth: Yes
 Body: AccountSettings
 Response: BasicResponse
*/
    https://api.omg.lol/account/accounts@icalvin.dev/info/
    private let addressAvailability = "address/{address}/availability"
/*
 GET
 Auth: No
 Body: None
 Response: [
   message: String?
   punycody: String?
   address: String
   available: Bool
   availability: String
 ] 
*/
    
    private let addressExpiration = "address/{address}/expiration"
/*
 GET
 Auth: No
 Body: None
 Response: AddressExpirationState
*/
    
    private let addressInfo = "address/{address}/info/"
/*
 GET
 Auth: Yes/No
 Body: None
 Response: AddressInfo
*/
    
    private let addressDNS = "address/{address}/dns"
/*
 GET
 Auth: Yes
 Body: None
 Response: [
   message: String?
   dns: [DNSRecord]
 ]
 
 POST
 Auth: Yes
 Body: NewDNSRequest
 Respnose: EditDNSResponse
*/

    private let editDNS = "address/{address}/dns/{dnsId}"
/*
 PATCH
 Auth: Yes
 Body: EditDNSRequest
 Response: EditDNSResponse
 
 DELETE
 Auth: Yes
 Body: None
 Response: BasicResponse
*/
    
    private let publicDirectory = "directory/"
/*
 GET
 Auth: No
 Body: None
 Response: [
   message: String?
   directory: [String]
 ]
*/
    
    private let forwardingEmail = "address/{address}/email/"
/*
 GET
 Auth: Yes
 Body: None
 Response: EmailForwards
 
 POST
 Auth: Yes
 Body: [
   destination: String (array joined with ", ")
 ]
 Response: EmailForwards
*/
    
    private let now = "address/{address}/now/"
/*
 GET
 Auth: No
 Body: None
 Response: [
   message: String?
   now: AddressNow
 ]
 
 POST
 Auth: Yes
 Body: [
   content: String
   listed: Bool
 ]
 Response: BasicResponse
*/
    
    private let nowGarden = "now/garden/"
/*
 GET
 Auth: No
 Body: None
 Response: [
   message: String?
   garden: [
     address: String
     url: String
     updated: TimeStamp
   ]
 ]
*/
    
    private let addressPURLs = "address/{address}/purls"
/*
 GET
 Auth: Yes
 Body: None
 Response: [
   message: String?
   purls: [AddressPURL]
 ]
*/
    
    private let createPURL = "address/{address}/purl"
/*
 POST
 Auth: Yes
 Body: [
   name: String
   url: String
 ]
 Response: [
   message: String?
   name: String
   url: String
 ]
*/
    
    private let managePURL = "address/{address}/purl/{purlName}"
/*
 GET
 Auth: Yes
 Body: None
 Response: [
   message: String?
   purl: AddressPurl
 ]
 
 DELETE
 Auth: Yes
 Body: None
 Response: BasicResponse
*/
    
    private let addressPastes = "address/{address}/pastebin/"
/*
 GET
 Auth: Yes/No
 Body: None
 Response: [
   message: String?
   pastebin: [AddressPaste]
 ]
 
 POST
 Auth: Yes
 Body: [
   title: String
   content: String
 ]
 Response: [
   message: String?
   title: String
 ]
*/
    
    private let addressPaste = "address/{address}/pastebin/{pasteTitle}/"
/*
 GET
 Auth: No
 Body: None
 Resposne: [
   message: String?
   paste: AddressPsate
 ]
 
 DELETE
 Auth: Yes
 Body: None
 Response: BasicResponse
*/
    
    private let serviceInfo = "service/info/"
/*
 GET
 Auth: No
 Body: None
 Response: [
   message: String?
   members: Int
   addresses: Int
   profiles: Int 
 ]
*/

    private let status = "address/{address}/statuses/{statusId}"
/*
 GET
 Auth: No 
 Body: None
 Response: [
   message: String?
   status: AddressStatus
 ]
*/
    
    private let statuses = "address/{address}/statuses"
/*
 GET
 Auth: No 
 Body: None
 Response: [
   message: String?
   statuses: [AddressStatus]
 ]
 
 POST
 Auth: Yes
 Body: NewStatus
 Reseponse: AccountStatus
 
 POST
 Auth: Yes
 Body: [
   status: String
 ]
 response: AccountStatus
 
 PATCH
 Auth: Yes
 Body: None
 Response: AddressStatus
*/
    
    private let statuslogBio = "address/{address}/statuses/bio"
/*
 GET
 Auth: No
 Body: None
 Response: [
   message: String?
   bio: String?
   css: String?
 ]
 
 POST
 Auth: Yes
 Body: [
   content: String
   css: String?
 ]
*/
    
    private let completeStatusLog = "statuslog/"
/*
 GET
 Auth: No
 Body: None
 Response: [
   message; String?
   statuses: [AddressStatus]
 ]
*/
    
    private let latestStatusLog = "statuslog/latest"
/*
 GET
 Auth: No
 Body: None
 Response: [
   message: String?
   statuses: [AddressStatus]
 ]
*/
    
    private let themes = "theme/list/"
/*
 GET
 Auth: No
 Body: None
 Response: [
   message: String?
   themes: [String: ProfileTheme]
 ]
*/
    
    private let themeInfo = "theme/{theme}/info/"
/*
 GET
 Auth: No
 Body: None
 Response: [
   theme: ProfileTheme
 ]
*/
    
    private let themePreview = "theme/{theme}/preview"
/*
 GET
 Auth: No
 Body: None
 Response: [
   message: String?
   html: String
 ]
*/
    
    private let addressWebPage = "address/{address}/web/"
/*
 GET
 Auth: Yes/No
 Body: None
 Response: [
   message: String
   content: String
   type: String
   css: String
   head: String
   verified: Bool
   pfp: String?
   metadata: [String: String]
   branding: default
 ]
 
 POST
 Auth: Yes
 Body: [
   publish: Bool
   content: String
 ]
 Response: BasicResponse
*/
    
    private let profilePhoto = "address/{address}/pfp/"  
/*
 POST
 Auth: Yes
 Body: {multi-part}
 Response: BasicResponse
*/
    
    private let weblogConfiguration = "address/{address}/weblog/configuration"
/*
 GET
 Auth: Yes
 Body: None
 Response: [
   message: String?
   raw: String
 ]
 
 POST
 Auth: Yes
 Body: [
   data: String
 ]
 Response: BasicResponse
*/
    
    private let weblogTemplate = "address/{address}/weblog/template"
/*
 GET
 Auth: Yes
 Body: None
 Response: [
   message: String?
   templet: String
 ]
 
 POST
 Auth: Yes
 Body: [
   data: String
 ]
 Response: BasicResponse
*/
    
    private let weblogEntries = "address/{address}/weblog/entries/"
/*
 GET
 Auth: Yes/No
 Body: None
 Response: [
   message: String?
   entries: [WeblogEntry]
 ]
*/
    
    private let latestEntry = "address/{address/weblog/post/latest/"
/*
 GET
 Auth: No
 Body: None
 Response: [
   message: String?
   post: WeblogEntry?
 ]
*/
    
    private let manageEntry = "address/{address}/weblog/entry/{entry}/"
/*
 GET
 Auth: Yes/No
 Body: None
 Response: [
   message: String?
   entry: WeblogEntry
 ]
 
 POST
 Auth: Yes
 Body: [
   data: String
 ]
 Response: [
   message: String?
   post: WeblogEntry
 ]
 
 DELETE
 Auth: Yes
 Body: None
 Response: BasicResponse
*/
