# PA: Product and Presentation

The Popcorn Post aims to be the go-to collaborative news platform where cinema and entertainment enthusiasts actively engage, share, and explore their passion while fostering a trusted and vibrant community.

## A9: Product

The goal of this artifact is to provide a concise overview of the completed product, covering usage, application help, input validation, accessibility and usability, HTML & CSS validation, and implementation details. It also includes an installation guide for local deployment, as well as user credentials.

The Popcorn Post is a dynamic collaborative news platform designed for cinema and entertainment enthusiasts. In this platform, you can engage in vibrant discussions, create compelling news articles, and explore trending tags. The Popcorn Post provides a seamless and interactive environment for entertainment enthusiasts to share, learn, and connect.  

### 1. Installation

Link to the release with the final version of the source code in the group's Git repository: [PA](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/tree/PA)

Docker command to start the image available at the group's GitLab Container Registry using the production database:
```
docker run -it -p 8000:80 --name=lbaw2356 -e DB_DATABASE="lbaw2356" -e DB_SCHEMA="lbaw2356" -e DB_USERNAME="lbaw2356" -e DB_PASSWORD="LPJJWjum" git.fe.up.pt:5050/lbaw/lbaw2324/lbaw2356
```

### 2. Usage

The final product is available online [here](https://lbaw2356.lbaw.fe.up.pt).

#### 2.1. Administration Credentials

Administration URL: [Administration](https://lbaw2356.lbaw.fe.up.pt/administration)

| Email | Password |
| -------- | -------- |
| jessica.pearson@popcornpost.com    | 1234 |
| harvey.specter@popcornpost.com    | 1234 |

#### 2.2. User Credentials

| Type          | Email  | Password |
| ------------- | --------- | -------- |
| basic member account | donna.paulsen@popcornpost.com    | 1234 |
| news contributor | donna.paulsen@popcornpost.com    | 1234 |
| comment contributor | donna.paulsen@popcornpost.com    | 1234 |
| blocked account | louis.litt@popcornpost.com    | 1234 |

### 3. Application Help

In the application interface, various elements have been strategically implemented to assist users in navigating, troubleshooting, and understanding the system. Here's a breakdown of the different help features:

**Input Error Messages**

When users encounter input errors while interacting with the application, a helpful feature has been incorporated to guide them through the resolution process. These error messages, as illustrated in Figure 1, provide clear and concise feedback on what went wrong and offer guidance on how to rectify the issue. For instance, if a user submits a form with missing or invalid information, they will receive a specific error message pointing out the problematic fields and suggesting corrections.

![Input_Error_Messages](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/raw/main/artefacts/pa/images/input_error_messages.png) 

Figure 1: Input Error Messages.

**Success Messages**

On the flip side, the application reinforces positive interactions by displaying success messages upon the successful completion of tasks. These messages, as depicted in Figure 2, confirm to users that their actions were executed successfully. Whether it's submitting a form, updating information, or other, users receive visual confirmation that their task was completed without any issues.

![Success_Message](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/raw/main/artefacts/pa/images/success_message.png) 

Figure 2: Success Message.

**Contextual Help Clues**

To enhance user understanding and provide context-sensitive assistance, the application incorporates contextual help clues. As shown in Figure 3, users can access further information about different available actions within the platform.

![Contextual_Help](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/raw/main/artefacts/pa/images/contextual_help.png) 

Figure 3: Contextual Help Clue.

**Sitemap Page**

For a comprehensive overview of the application's structure and navigation, the Sitemap Page, as depicted in Figure 4, serves as a valuable resource. Users can refer to this page to understand the organization of the application, making it easier for them to locate specific sections or functionalities.

![Sitemap_Page](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/raw/main/artefacts/pa/images/sitemap_page.png) 

Figure 4: Sitemap Page.

**Contacts Page**

In instances where users require direct assistance or have specific inquiries, the Contacts Page, showcased in Figure 5, serves as a hub for relevant contact information. Whether it's reaching out for technical support, providing feedback, or seeking clarification, users can find the necessary contact details on this page. 

![Contacts_Page](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/raw/main/artefacts/pa/images/contacts_page.png)
 
Figure 5: Contacts Page.
 
### 4. Input Validation

Input validation is implemented at both the client and server levels for a robust data integrity strategy.

**Client-Side Validation:**

Type Attributes: Specify input types like "email" or "password" to ensure proper format.

Required Attribute: Flag mandatory fields with the "required" attribute to prompt user completion.
  
```php
<input id="email" type="email" name="email" value="{{ old('email') }}" required>
```
```php
<input id="password" type="password" name="password" required>
```

**Server-Side Validation (Using Laravel):**

Laravel Validate Method: Define rules for input fields to comprehensively validate incoming requests.

```php
$validatedData = $request->validate([
    'user_email' => 'required|email',
    'user_password' => 'required|min:8',
]);
```

Custom Regular Expressions: Use custom regex for specific validation needs (e.g., password specifications), along with custom error messages that would otherwise be unattainable with the Laravel Validate Method.

```php
if (!preg_match('/[a-z]/', $password)) {
    return redirect()->back()->withInput()->withErrors([
        'password' => 'Password must contain at least one lowercase letter.'
    ]);
}
```

This dual-layer approach ensures a secure and user-friendly system, preventing both inadvertent errors and malicious input.
 

### 5. Check Accessibility and Usability

The results of the accessibility and usability tests can be found in the following links:

- [Accessibility](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/blob/main/artefacts/pa/ChecklistdeAcessibilidade-SAPOUX.pdf?ref_type=heads) 

- [Usability](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/blob/main/artefacts/pa/ChecklistdeUsabilidade-SAPOUX.pdf?ref_type=heads)  

### 6. HTML & CSS Validation

The results of the validation of the HTML and CSS code can be found in the following links:

- [HTML Home Page](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/blob/main/artefacts/pa/HTMLValidation-Home.pdf?ref_type=heads)

- [HTML News Article Page](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/blob/main/artefacts/pa/HTMLValidation-Article.pdf?ref_type=heads)

- [HTML Search Page](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/blob/main/artefacts/pa/HTMLValidation-Search.pdf?ref_type=heads)

- [HTML Administration Page](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/blob/main/artefacts/pa/HTMLValidation-Administration.pdf?ref_type=heads)

- [CSS](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/blob/main/artefacts/pa/CSSValidation.pdf?ref_type=heads)

### 7. Revisions to the Project

Revisions made to the project since the requirements specification stage:

- **ER:** 
     - Added a detailed explanation of the roles of the News Contributor and the Comment Contributor 
     - Improved the artefact's description
     - Specified that the OAuth API is provided by Google 
     - Split Search for News Items and Search for Comments into two user stories (US007 and US008)
     - Updated the Sitemap to comply with the most recent structure (changes to General Information Pages, Administration Pages and News Related Pages)

- **EBD:** 
     - Fixed the data anonymization trigger (data_anonymization)
     - Fixed the Member-Edit association name in the UML class diagram
     - Repopulated the database with more data
     - Added the remember password token (remember_token) and the Google ID (google_id) fields to the Member table
     - Added a trigger to remove a member's unblock appeal once that member is unblocked (delete_appeals)

- **EAP:** 
     - Removed a duplicate of an implemented user story
     - Changed the logout route to be a POST method
     - Added routes to the tag page, topic suggestions, Google authentication, file upload and unblock appeals


### 8. Implementation Details

#### 8.1. Libraries Used

- [Laravel](https://laravel.com/)
   - **Description:** Server-side framework for building web applications.
   - **Usage in Product:** Laravel is the core framework for handling server-side logic, routing, and database interactions.

- [Bootstrap Icons](https://icons.getbootstrap.com/)
   - **Description:** Icons and button styling from the Bootstrap framework.
   - **Usage in Product:** Bootstrap Icons are used for consistent iconography and button styling.

- [FontAwesome](https://fontawesome.com/)
   - **Description:** Icon library providing a wide range of icons.
   - **Usage in Product:** FontAwesome icons are utilized for various elements throughout the user interface.

- [Pusher](https://pusher.com/)
   - **Description:** Service for real-time interaction with users.
   - **Usage in Product:** Pusher is integrated into the notification system to provide real-time updates to users.

- [Mailtrap.io](https://mailtrap.io/)
   - **Description:** Service for sending emails via Email API/SMTP and testing.
   - **Usage in Product:** Mailtrap.io is used for sending emails, especially in the user password recovery system.

- [Filepond](https://pqina.nl/filepond/)
   - **Description:** Library for managing file uploads, especially images.
   - **Usage in Product:** Filepond is utilized for effective management of image uploads.

- [TailwindCSS](https://tailwindcss.com/)
   - **Description:** Front-end development framework focusing on utility-first CSS.
   - **Usage in Product:** TailwindCSS is the primary framework for styling the front-end, providing a utility-first approach.

- [Socialite](https://laravel.com/docs/socialite)
   - **Description:** Laravel package for authentication with social networks.
   - **Usage in Product:** Socialite is used for Google authentication within the Laravel application. 


#### 8.2 User Stories

|US Identifier|Name|Module|Priority|Team Members|State|
|---|---|---|---|---|---|
|US001|View Top News|M02: Content Items|High|**Marco Costa**|100%|
|US002|View News Items|M02: Content Items|High|**Marco Costa**|100%|
|US003|Exact Match Search|M07: Search|High|**João Ramos**|100%|
|US004|Full-Text Search|M07: Search|High|**João Ramos**|100%|
|US005|View Recent News|M02: Content Items|Medium|**Marco Costa**|100%|
|US006|View News Item Comments|M02: Content Items|Medium|**Marco Costa**|100%|
|US007|Search for News Items|M07: Search|Medium|**João Ramos**|100%|
|US008|Search for Comments|M07: Search|Medium|**João Ramos**|100%|
|US009|Search Over Multiple Attributes|M07: Search|Medium|**João Ramos**|100%|
|US010|Search Filters|M07: Search|Medium|**João Ramos**|100%|
|US011|Placeholders In Form Inputs|All Modules|Medium|**Tiago Viana**, Marco Costa, João Ramos, Diogo Gomes|100%|
|US012|Contextual Error Messages|All Modules|Medium|**Tiago Viana,** João Ramos|100%|
|US013|Contextual Help Clues|All Modules|Medium|**João Ramos,** Tiago Viana|100%|
|US014|'About US' Section|M08: Member Administration and Static Pages|Medium|**Diogo Gomes**|100%|
|US015|Main Features Section|M08: Member Administration and Static Pages|Medium|**Diogo Gomes**|100%|
|US016|Contact Information|M08: Member Administration and Static Pages|Medium|**Diogo Gomes**|100%|
|US017|Order Search Results|M07: Search|Low|**João Ramos**|100%|
|US018|Related News|M02: Content Items|Low|**Tiago Viana**|100%|
|US019|Same Author News|M02: Content Items|Low|**Tiago Viana**|100%|
|US020|View Tag Page|M03: Votes and Tags|Low|**Tiago Viana**|100%|
|US021|Search for Tags|M07: Search|Low|**João Ramos**|100%|
|US022|Search for Users|M07: Search|Low|**João Ramos**|100%|
|US023|Order comments|M02: Content Items|Low|**Marco Costa**|100%|
|US024|Trending Tags|M02: Content Items|Low|**Tiago Viana**, Marco Costa|100%|
|US101|Login|M01: Authentication and Individual Profile|High|**João Ramos**|100%|
|US102|Register|M01: Authentication and Individual Profile|High|**João Ramos**|100%|
|US103|Recover Password|M01: Authentication and Individual Profile|Medium|**João Ramos**|100%|
|US104|Login with Google Account|M01: Authentication and Individual Profile|Low|**João Ramos**|100%|
|US105|Register with Google Account|M01: Authentication and Individual Profile|Low|**João Ramos**|100%|
|US201|Logout|M01: Authentication and Individual Profile|High|**João Ramos**|100%|
|US202|View News Item Details|M02: Content Items|High|**Marco Costa**|100%|
|US203|Member News Feed|M02: Content Items|High|**Marco Costa**|100%|
|US204|View Other Members' Profiles|M01: Authentication and Individual Profile|High|**Tiago Viana**|100%|
|US205|View Profile|M01: Authentication and Individual Profile|High|**Tiago Viana**|100%|
|US206|Edit Profile|M01: Authentication and Individual Profile|High|**Tiago Viana**|100%|
|US207|Create News Items|M02: Content Items|High|**Diogo Gomes**|100%|
|US208|Comment on News Items|M02: Content Items|Medium|**Marco Costa**|100%|
|US209|View Comment Details|M02: Content Items|Medium|**Marco Costa**|100%|
|US210|Vote on News Items|M02: Content Items|Medium|**Diogo Gomes**|100%|
|US211|Vote on Comments|M03: Votes and Tags|Medium|**Diogo Gomes**|100%|
|US212|View Reputation of Other Members|M05: Members|Medium|**Tiago Viana**|100%|
|US213|View News Item Tags|M03: Votes and Tags|Medium|**Marco Costa**|100%|
|US214|Follow/Unfollow Members|M05: Members|Medium|**Tiago Viana**|100%|
|US215|Follow/Unfollow Tags|M03: Votes and Tags|Medium|**Tiago Viana**|100%|
|US216|Upvote Notifications|M06: Notifications|Medium|**Marco Costa**|100%|
|US217|Comment Notifications|M06: Notifications|Medium|**Marco Costa**|100%|
|US218|Delete Account|M01: Authentication and Individual Profile|Medium|**Tiago Viana**|100%|
|US219|Profile Picture|M01: Authentication and Individual Profile|Medium|**Tiago Viana**|100%|
|US220|View Personal Notifications|M06: Notifications|Medium|**Marco Costa**|100%|
|US221|Propose New Topics|M04: Topics|Low|**Tiago Viana**|100%|
|US222|Add/Remove News Items from Favorites|M02: Content Items|Low||0%|
|US223|Report Members or Content|M05: Members|Low||0%|
|US224|Appeal for Unblock|M08: Member Administration and Static Pages|Low|**Tiago Viana**|100%|
|US225|Reputation Based Tiers|M05: Members|Low||0%|
|US226|Reply to Article Comments|M02: Content Items|Low|**Marco Costa**|100%|
|US227|Comments Tab on Members' Profile|M01: Authentication and Individual Profile|Low|**Tiago Viana**, Marco Costa|100%|
|US228|"Following" Section|M01: Authentication and Individual Profile|Low|**Tiago Viana**|100%|
|US301|Edit News Items|M02: Content Items|High|**Diogo Gomes**|100%|
|US302|Delete News Items|M02: Content Items|High|**Diogo Gomes**|100%|
|US303|Highlight Person/Movie|M02: Content Items|Low||0%|
|US401|Edit Comments|M02: Content Items|Medium|**Marco Costa**|100%|
|US402|Delete Comments|M02: Content Items|Medium|**Marco Costa**|100%|
|US501|Administer Member Accounts|M08: Member Administration and Static Pages|High|**Tiago Viana**|100%|
|US502|Manage Topic Proposals|M04: Topics|Medium|**Tiago Viana**|100%|
|US503|Admin Account Privileges|M08: Member Administration and Static Pages|Medium|**Tiago Viana**|100%|
|US504|Block/Unblock Member Accounts|M08: Member Administration and Static Pages|Medium|**Tiago Viana**|100%|
|US505|Delete Member Accounts|M08: Member Administration and Static Pages|Medium|**Tiago Viana**|100%|
|US506|Manage Content and Member Reports|M08: Member Administration and Static Pages|Low||0%|
|US507|Administration Dashboard Statistics|M08: Member Administration and Static Pages|Low|**Tiago Viana**|100%|
|US508|Manage Topics|M08: Member Administration and Static Pages|Low|**Tiago Viana**|100%|
|US509|Edit History|M02: Content Items|Low||0%|
|US510|Manage Tags|M08: Member Administration and Static Pages|Low|**Tiago Viana**|100%|

---

## A10: Presentation
 
The goal of this artifact is to present the final product. It includes a brief presentation of the product and its main features, as well as a video presentation of the working website.

### 1. Product presentation

The Popcorn Post is a dynamic news-sharing platform where members are encouraged to contribute, discover, and engage with a variety of news articles on diverse topics. The platform's easy-to-use interface allows users to create and curate content, fostering a sense of community and enabling compelling discussions. The Academy Score rating system ensures content quality along the platform and serves as a popularity indicator for news articles, comments and members.

At the core of The Popcorn Post is a tagging system that guarantees content relevance, making it easy for members to explore diverse themes and join discussions on matters that are trending or that they are interested in. The voting feature allows the community to collectively assess content quality, and the administration features facilitate member and content management. With personalized feeds, based on the members and the tags a user follows, the platform is designed to offer a tailored user experience, emphasizing community-driven content curation.

URL to the product: https://lbaw2356.lbaw.fe.up.pt


### 2. Video presentation

[Link to the lbaw2356.mp4 file](https://drive.google.com/file/d/1P8KQqL8ZSYvwvpM0H-35O7rSGGU1GwIz/view?usp=sharing)

![Video_Screenshot](https://git.fe.up.pt/lbaw/lbaw2324/lbaw2356/-/raw/main/artefacts/pa/images/video.png)

---


## Revision history

Changes made to the first submission:
1. ...

***
GROUP2356, 21/12/2023

* Tiago Filipe Castro Viana, [up201807126@up.pt](mailto:up201807126@up.pt) (Editor)
* João Filipe Oliveira Ramos, [up202108743@up.pt](mailto:up202108743@up.pt)
* Marco André Pereira da Costa, [up202108821@up.pt](mailto:up202108821@up.pt)
* Diogo Alexandre Figueiredo Gomes, [up201905991@up.pt](mailto:up201905991@up.pt)