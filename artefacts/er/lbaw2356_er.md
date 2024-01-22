# ER: Requirements Specification Component

The Popcorn Post aims to be the go-to collaborative news platform where cinema and entertainment enthusiasts actively engage, share, and explore their passion while fostering a trusted and vibrant community.

## A1: The Popcorn Post

The Popcorn Post is a cutting-edge web-based platform designed for individuals who are deeply passionate about cinema, TV shows, and the ever-evolving world of entertainment. Developed with a shared eagerness for all things screen-related, The Popcorn Post is set to be the epicenter for enthusiasts to come together, share news, and explore their interests in the cinematic industry.

At the core of The Popcorn Post's mission is the creation of an interactive collaborative news website. Our aim is to provide a vibrant online space where entertainment enthusiasts actively participate in creating, sharing, and discussing cinema-related news articles. This platform empowers users not only to consume but also contribute to the news articles, fostering a sense of community through features that enable following fellow users and tags, therefore staying connected with their preferred entertainment niches. 

Additionally, The Popcorn Post incorporates a robust rating and reputation system. This system empowers users to evaluate news and comments, allowing for the recognition of contributors who consistently provide valuable and reliable content. The reputation system further enhances the sense of trust and accountability within our community, encouraging high-quality engagement and content creation.

Users will be categorized into three specific groups: non-authenticated users (guests), authenticated users (members), and administrators. The Popcorn Post prioritizes user authentication to ensure secure access. Guests can easily register and log in, unlocking personalized content and privileges such as posting news articles and following their favorite tags. Additionally, administrators possess the power to oversee content and user accounts, creating a safe and interactive environment with the ability to manage topics, tags and content when necessary. Members enjoy autonomy in managing their content and preferences.

Our advanced search feature simplifies content discovery, allowing users to locate specific users, tags, and articles effortlessly through various filters like topics and popularity. Users can explore the latest news, trending tags, or top-rated news, enhancing their content exploration experience.

For members, core features come to life, enabling them to create, share, rate, and comment on news articles. Members can also manage news articles and comments authored by them, as well as reply to other members' comments in an article. The Popcorn Post serves as a vibrant hub for user-generated content and collaboration.

The platform is designed to empower members to share their passion through content creation and curation, further enriched by a robust rating system that elevates content quality. A reputation system recognizes dependable contributors, nurturing trust within the community.

Every user has the capability to view other user profiles, and members can edit their own profiles, ensuring a personalized and engaging experience on The Popcorn Post.

---

## A2: Actors and User stories

This artefact outlines project requirements, including actor roles, user stories and other supplementary requirements.

### 1\. Actors

![actors](uploads/7cd780c43023a59bb07f5aa6584a9004/actors.jpg)

Figure 1: The Popcorn Post's actors.


| **Identifier**      | **Description**                                                                                                                                                                                                                                                                                |
|---------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|         User        |                                                                                                 Generic user that has access to public information, such as news articles, comments and topics.                                                                                                |
|        Guest        |                                                                                                      Unauthenticated user that can register themselves (sign-up) or sign-in in the system.                                                                                                     |
|        Member       | Authenticated user that is able to post news articles and comments, as well as edit all news articles and comments authored by themselves. A member is also capable of following other members and tags, and upvoting or downvoting news articles and comments authored by other members. |
|   News Contributor  |                                                                          Authenticated user that belongs to the same location as the creator of a news article and is able to edit or delete the existing information.                                                                         |
| Comment Contributor |                                                                            Authenticated user that belongs to the same location as the creator of a comment and is able to edit or delete the existing information.                                                                            |
|    Administrator    |                                                                                   Authenticated user that is responsible for managing users and monitoring content (ie., news articles, comments, tags and topics).                                                                                  |
|      OAuth API      |                                                                                                    An external OAuth API that enables user registration or authentication within the system.                                                                                                   |
|       IMDb-API      |                                                                    An external IMDb API that provides essential movie and TV show data, enriching the platform with up-to-date information from the world of entertainment.                                                                    |

Table 1: The Popcorn Post actors' description.

### 2\. User Stories

#### 2\.1. User

| Identifier | Name                            | Priority        | Description                                                                                                                                                                  |
|------------|---------------------------------|-----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| US001      | View Top News                        | High            | As a user, I want a page of top news, so that I can view the most upvoted news in a selected time frame.                                                           |
| US002      | View News Items                      | High            | As a user, I want to access news items, so that I can see articles in further detail, such as their full extent, comments and related news.                              |
| US003      | Exact Match Search              | High            | As a user, I want to use exact match search, so that I can quickly and precisely find the specific information or content I'm looking for.                                   |
| US004      | Full-Text Search                | High            | As a user, I want to use full-text search, so that I can find a variety of differently related content.                                                                      |
| US005      | View Recent News                     | Medium          | As a user, I want a page of recent news, so that I can view the latest news.                                                                                       |
| US006      | View News Item Comments         | Medium          | As a user, I want to view news item comments, so that I can stay informed about public opinion and discussions about current events.                                             |
| US007      | Search for News Items and Comments       | Medium          | As a user, I want to search for news items and comments, so that I quickly find information on specific themes of interest.                                                  |
| US008      | Search Over Multiple Attributes | Medium          | As a user, I want to search over multiple attributes, so that I can find content that fits a certain time interval, amount of upvotes or downvotes or others. |
| US009      | Search Filters                  | Medium          | As a user, I want to apply search filters, so that I can specify the type of content I am looking for.                                          |
| US010      | Placeholders In Form Inputs     | Medium          | As a user, I want to have placeholders in form inputs, so that filling different forms(e.g.: creating news articles, registration, etc.) is more intuitive.                                                                 |
| US011      | Contextual Error Messages       | Medium          | As a user, I want to receive contextual error messages, so that I can understand why an action or input failed and take appropriate corrective actions efficiently.                            |
| US012      | Contextual Help Clues           | Medium          | As a user, I want contextual help clues, so that I can navigate and utilize the system more effectively.                                                           |
| US013      | 'About US' Section              | Medium          | As a user, I want an 'About US' section, so that I can have a better understanding of the platform's main goal and motivation.                                            |
| US014      | Main Features Section           | Medium          | As a user, I want a main features section, so that I can read about available key features within the platform that could otherwise go unnoticed.                            |
| US015      | Contact Information             | Medium          | As a user, I want contact information, so that I can get custom support for more complex issues within the platform.                                                     |
| US016      | Order Search Results            | Low             | As a user, I want to order search results, so that information is displayed and sorted according to what I deem most relevant.                                          |
| US017      | Related News                    | Low             | As a user, I want to see related news when reading an article, so that I can explore the themes of the article further and stay informed.                                                         |
| US018      | Same Author News                | Low             | As a user, I want to receive suggestions for more articles by the same author of the news item I am reading, so that I can easily explore more of their work.                     |
| US019      | View Tag Page           | Low          | As a user, I want to view a dedicated tag page, so that I can explore all the news articles and discussions related to a specific theme.                            |
| US020      | Search for Tags             | Low          | As a user, I want to search for tags, so that I can easily find and explore specific themes.                                                     |
| US021      | Search for Users            | Low             | As a user, I want to search for users, so that I can easily find and explore content by specific users.                                          |
| US022      | Order comments                    | Low             | As a user, I want to order comments inside a news article, so that comments are displayed and sorted according to what I deem most relevant.                                                         |
| US023      | Trending Tags                | Low             | As a user, I want to see trending tags when I'm reading my feed, so that I can stay informed about popular and current themes within the community.                     |

Table 2: User's user stories.

#### 2\.2. Guest

| Identifier | Name             | Priority | Description                                                                                                                                        |
|------------|------------------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| US101      | Login            | High     | As a guest, I want to login into the platform, so that I can access my personalized content and features.                                          |
| US102      | Register         | High     | As a guest, I want to register on the platform, so that I can create an account where I can have a more personalized experience with the platform. |
| US103      | Recover Password | Medium   | As a guest, I want to be able to recover my password, so that I can regain access to my account in case I forget or lose my password.             |

Table 3: Guest's user stories.

#### 2\.3. Member

| Identifier | Name                                 | Priority | Description                                                                                                                                                                                    |
|------------|--------------------------------------|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| US201      | Logout                               | High     | As a member, I want to log out of the platform, so that my account privacy is secured.                                                                                                         |
| US202      | View News Item Details               | High     | As a member, I want to view news item details, so that I can see its author, publication date, votes, and other exclusive information.                                                         |
| US203      | Member News Feed                     | High     | As a member, I want to access a customized news feed, so that I can view content related to my interests (i.e., tags and members I follow).                                                  |
| US204      | View Other Members' Profiles         | High     | As a member, I want to view other members' profiles, so that I can see news articles they authored and follow them.                                                                            |
| US205      | View Profile                         | High     | As a member, I want to view my profile, so that I can review and manage my personal information, preferences, and activity on the platform.                                                    |
| US206      | Edit Profile                         | High     | As a member, I want to edit my profile, so that I can update my personal information, preferences, and other details to ensure my profile reflects my current status and interests accurately. |
| US207      | Create News Items                    | High     | As a member, I want to create news items, so that I can write about and share recent news.                                                                                           |
| US208      | Comment on News Items                | Medium   | As a member, I want to comment on news items, so that I can share my opinion of news articles of interest.                                                                        |
| US209      | View Comment Details                 | Medium   | As a member, I want to view comment details, so that I can view its author, publication date, votes, and others.                                                                               |
| US210      | Vote on News Items                   | Medium   | As a member, I want to vote on news items, so that I can evaluate news according to their relevance or quality.                                                                                |
| US211     | Vote on Comments                     | Medium   | As a member, I want to vote on comments, so that I can evaluate comments according to their relevance or quality.                                                                              |
| US212      | View Reputation of Other Members     | Medium   | As a member, I want to view the reputation of other members, so that I can evaluate a member's content liability.                                                                              |
| US213      | View News Item Tags                  | Medium   | As a member, I want to view news item tags, so that I can follow tags of interest or view relevant news related to them.                                                                       |
| US214      | Follow/Unfollow Members              | Medium   | As a member, I want to follow/unfollow members, so that I can change whether or not their content is displayed on my customized feed.                                                          |
| US215      | Follow/Unfollow Tags                 | Medium   | As a member, I want to follow/unfollow tags, so that I can change whether or not content related to those tags appears on my customized feed.                                                  |
| US216      | Upvote Notifications                 | Medium   | As a member, I want to receive notifications when my content gets upvoted, so that I can track community feedback on my content.                                                               |
| US217      | Comment Notifications                | Medium   | As a member, I want to receive notifications when my content gets comments, so that I can track community opinions and activity related to my content.                                         |
| US218      | Delete Account                       | Medium   | As a member, I want to be able to delete my account, so that I have control over my personal data and can ensure that my information is no longer accessible or used by the platform.          |
| US219      | Profile Picture                      | Medium   | As a member, I want to have a profile picture, so that my profile feels more personal and further emphasizes the personality behind my content.                                                |
| US220      | View Personal Notifications          | Medium   | As a member, I want to view personal notifications, so that I can easily keep up with the community activity related to my articles and comments.                                              |
| US221      | Propose New Topics                   | Low      | As a member, I want to propose new topics, so that news articles may fit topics currently not present in the platform.                                                                         |
| US222      | Add/Remove News Items from Favorites | Low      | As a member, I want to add/remove news items from favorites, so that I can save news articles I want to view later.                                                                            |
| US223      | Report Members or Content            | Low      | As a member, I want to report members or content, so that administrators take notice of inappropriate content or behavior within the platform.                                                 |
| US224      | Appeal for Unblock                   | Low      | As a member, I want to appeal for unblock, so that I can rectify possible misunderstandings and be justly unblocked.                                                                           |
| US225      | Reputation Based Tiers               | Low      | As a member, I want to have different tiers based on my reputation, so that the recognition for my contribution is highlighted.                                                                |
| US226      | Reply to Article Comments            | Low      | As a member, I want to reply to article comments, so that I can engage in conversations, share my thoughts, and contribute to discussions related to the article.                              |
| US227      | Comments Tab on Members' Profile     | Low      | As a member, I want to see a comments tab on members' profile, so that I can easily track the activity of other members.                                                                       |
| US228      | "Following" Section                  | Low      | As a member, I want to have a dedicated "Following" section, so that I can manage members and tags I follow.|

Table 4: Member's user stories.

#### 2\.4. News Contributor

| Identifier | Name                            | Priority     | Description                                                                                                                           |
|------------|---------------------------------|--------------|---------------------------------------------------------------------------------------------------------------------------------------|
| US301      | Edit News Items                 | High         | As a news contributor, I want to edit news items authored by me, so that I can enhance the article information or correct possible inaccuracies. |
| US302      | Delete News Items               | High         | As a news contributor, I want to delete news items authored by me, so that I can remove any articles I've submitted that are no longer relevant or accurate. |
| US303      | Highlight Person/Movie           | Low          | As a news contributor, I want to highlight a person or movie related to the article, so that further information about them (e.g.:, brief description, rating, etc.) can be displayed adjacently to the article. |

Table 5: News Contributor's user stories.

#### 2\.5. Comment Contributor

| Identifier | Name                            | Priority     | Description                                                                                                                           |
|------------|---------------------------------|--------------|---------------------------------------------------------------------------------------------------------------------------------------|
| US401      | Edit Comments                   | Medium       | As a comment contributor, I want to edit comments, so that I can enhance their information or correct possible inaccuracies. |
| US402      | Delete Comments                 | Medium       | As a comment contributor, I want to delete comments, so that I can remove any comments I have submitted that are no longer relevant or accurate. |

Table 6: Comment Contributor's user stories.

#### 2\.6. Administrator

| Identifier | Name                             | Priority     | Description                                                                                                                           |
|------------|----------------------------------|--------------|---------------------------------------------------------------------------------------------------------------------------------------|
| US501      | Administer Member Accounts       | High         | As an administrator, I want to administer member accounts (i.e., search, view, edit, create), so that I can effectively manage and secure access to the platform resources and systems. |
| US502      | Manage Topic Proposals           | Medium       | As an administrator, I want to manage topic proposals, so that members are able to freely suggest new topics while filtering inappropriate suggestions. |
| US503      | Admin Account Privileges         | Medium       | As an administrator, I want to have an account with administrating privileges, so that I can oversee and manage the platform. |
| US504      | Block/Unblock Member Accounts    | Medium       | As an administrator, I want to block/unblock member accounts, so that misconducting members are inhibited from interacting with the platform and other members. |
| US505      | Delete Member Accounts           | Medium       | As an administrator, I want to delete member accounts, so that members deemed undeserving of remaining in the platform are removed (e.g.: misconduct, spam accounts, etc.). |
| US506      | Manage Content and Member Reports| Low          | As an administrator, I want to manage content and member reports, so that adherence to the platform guidelines and a safe and respectful environment are ensured. |
| US507      | Administration Dashboard Statistics   | Low          | As an administrator, I want to have a statistics tab on the administration dashboard, so that I can easily access and analyze key performance metrics and insights about the platform. |
| US508      | Manage Topics   | Low          | As an administrator, I want to manage topics, so that I can keep content organized on the platform. |
| US509      | Edit History    | Low          | As an administrator, I want to access the edit history of posts and comments so that I can track changes made to content over time and monitor for any inappropriate or malicious edits. |
| US510      | Manage Tags   | Low          | As an administrator, I want to manage tags, so that I can maintain the relevance and quality of tags on the platform. |

Table 7: Administrator's user stories.

### 3\. Supplementary Requirements

#### 3\.1. Business rules

| **Identifier** | **Name**                                         | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|----------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| BR001          | Data Anonymization                               | Shared user data, including news articles, comments, and votes, is retained after an account is deleted but is anonymized to protect user privacy.                                                                                                                                                                                                                                                                                                                                                                                   |
| BR002          | Deletion of Created Content                      | Members are not allowed to delete their articles or comments if they have been commented on or voted on.                                                                                                                                                                                                                                                                                                                                                                                                                             |
| BR003          | Edited News Article                              | An edited news article is flagged with an indicator ("edited").                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| BR004          | Edited Comment                                   | An edited comment is flagged with an indicator ("edited").                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| BR005          | Deleted News Article                             | All comments related to a news article are deleted upon that article's deletion.                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| BR006          | Deleted Comment                                  | All replies to a comment are deleted upon that comment's deletion.                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| BR007          | Banned Tag                                       | When a tag is deleted, it is automatically removed from all news articles that had it as a tag. That tag becomes unavailable to use in the platform.                                                                                                                                                                                                                                                                                                                                                                                 |
| BR008          | Changes to Content Notification                  | A member must be notified if an administrator edits or deletes any content authored by them.                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| BR009          | Topic Removal                                    | When a topic is deleted, it is automatically removed from all news articles that had it as a topic.                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| BR010          | 'Undefined' Topic Assignment                     | When an article has no assigned topic due to administrative reasons, this is assigned an 'undefined' topic and made unavailable to other members. The author is notified to change the article's topic accordingly.                                                                                                                                                                                                                                                                                                                  |
| BR011          | Voting System                                    | A member cannot concurrently upvote and downvote a news article or comment.                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| BR012          | Votes for Own Content                            | Members are not allowed to vote on their own news articles and comments.                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| BR013          | News Academy Score                               | A News Academy Score is calculated by the following formula: News Article's Number of Upvotes - News Article's Number of Downvotes.                                                                                                                                                                                                                                                                                                                                                                                                  |
| BR014          | Comment Academy Score                            | A Comment Academy Score is calculated by the following formula: Comment's Number of Upvotes - Comment's Number of Downvotes.                                                                                                                                                                                                                                                                                                                                                                                                         |
| BR015          | Member Academy Score                             | A Member Academy Score is calculated by the following formula: Sum of All Member's News Academy Score + Sum of All Member's Comments Academy Score.                                                                                                                                                                                                                                                                                                                                                                                  |
| BR016          | News Article Tags                                | A news article must have a maximum of six tags assigned to it.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| BR017          | News Article Topic                               | A news article must have one and only one topic assigned to it.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| BR018          | News Article Author                              | The author of a news article is highlighted (with a 'fountain pen' icon) in the comment section when they comment on their own articles.                                                                                                                                                                                                                                                                                                                                                                                             |
| BR019          | Blocked User Interaction Restrictions and Appeal | When a user account is blocked, the user loses the ability to interact with the site, including actions such as commenting, upvoting, reporting, and more. However, the blocked user can still view and access all platform content like normal users but is restricted from engaging in any form of interaction with the content or other users. The blocked user retains access to their own content and account settings, and they have the option to submit an appeal for unblocking if they believe the restriction was unjust. |
| BR020          | Deleted Content History                          | The edit history of a news article or comment must be maintained even if it is deleted by the author or the administrator.                                                                                                                                                                                                                                                                                                                                                                                                           |
| BR021          | Administrative Access                            | Administrators have special access rights and privileges within the system to perform administrative tasks effectively.                                                                                                                                                                                                                                                                                                                                                                                                              |
| BR022          | Member Management                                | Administrators can search for, view, edit, and create member accounts, enabling them to oversee user access to the platform.                                                                                                                                                                                                                                                                                                                                                                                                         |
| BR023          | Topic Control                                    | Administrators can manage topic proposals submitted by members, deciding whether to approve or reject them to maintain an organized topic structure.                                                                                                                                                                                                                                                                                                                                                                                 |
| BR024          | Tag Control                                      | Administrators can manage tags used by members, deciding whether they deem them appropriate and relevant for the platform.                                                                                                                                                                                                                                                                                                                                                                                                           |
| BR025          | Block/Unblock Authority                          | Administrators can block or unblock member accounts as needed, limiting or restoring user access in response to misconduct or policy violations.                                                                                                                                                                                                                                                                                                                                                                                     |
| BR026          | Account Deletion                                 | Administrators can permanently delete member accounts, removing users from the platform when their presence is inappropriate or in violation of platform policies.                                                                                                                                                                                                                                                                                                                                                                   |
| BR027          | Report Management                                | Administrators handle content and member reports, reviewing and taking action on reports of inappropriate behavior or content to maintain a safe platform environment.                                                                                                                                                                                                                                                                                                                                                               |
| BR028          | Dashboard Insights                               | Administrators can access a dashboard providing valuable statistics and insights about platform performance and user engagement, aiding in informed decision-making and monitoring platform health.                                                                                                                                                                                                                                                                                                                                  |
| BR029          | Feed Customization                               | Users can customize their feed preferences, such as following specific tags or users, to tailor their content discovery experience.                                                                                                                                                                                                                                                                                                                                                                                                  |
| BR030          | Trending Content                                 | The platform's main feed displays trending content based on factors like upvotes, comments, and recent activity to engage users with popular themes.                                                                                                                                                                                                                                                                                                                                                                                 |
| BR031          | Tag-Specific Feeds                               | Users can access tag-specific feeds, ensuring they can explore content within their areas of interest.                                                                                                                                                                                                                                                                                                                                                                                                                               |
| BR032          | Followed User Activity                           | A user's feed includes updates on the activity of followed users, such as new posts or comments.                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| BR033          | Report Feed Content                              | Users can report inappropriate or violating content directly from their feeds to maintain community guidelines.                                                                                                                                                                                                                                                                                                                                                                                                                      |
| BR034          | Feed Consistency                                 | The platform maintains consistency in the presentation and behavior of feeds across different devices and platforms.                                                                                                                                                                                                                                                                                                                                                                                                                 |
| BR035          | Comment Date Validation                          | A comment's date must exceed the original article's publication date.                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| BR036          | Reply Date Validation                            | A reply's date must exceed the original comment's date.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| BR037          | Notification Date Validation                     | A notification's date must exceed the date of the event that triggered it.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |

Table 8: The Popcorn Post's business rules

#### 3\.2. Technical requirements

|Identifier|Name|Description|
|---|---|---|
|**TR01**|**Performance**|**The system must exhibit response times under 2 seconds to retain user engagement.<br><br>In an interactive platform where users are expected to create, share, rate, and comment on news articles, slow response times can lead to frustration and decreased user activity. Fast response times are essential for retaining user interest and facilitating smooth interactions.**|
|**TR02**|**Security**|**The system must safeguard data against unauthorized access through robust authentication and verification mechanisms. <br><br>User authentication not only protects sensitive user information but also plays a pivotal role in enabling personalized experiences, content creation, and user interaction. It's essential for maintaining the integrity of the platform and fostering a secure environment.**|
|**TR03**|**Usability**|**The system should offer a user-friendly and straightforward experience.<br><br>Usability is vital to ensure that users, regardless of their technical experience, can easily navigate and engage with the platform. It contributes to user satisfaction and engagement, which are essential for the long-term success of the platform.**|
|TR04|Availability|The system must maintain a 99 percent uptime within each 24-hour period.|
|TR05|Accessibility|The system must ensure universal access to its pages, accommodating users with varying abilities and web browsers without discrimination.|
|TR06|Web Application|The system should be developed as a web application using modern web technologies such as HTML5, JavaScript, CSS3, and PHP.|
|TR07|Portability|The server-side component must be platform-agnostic, functioning seamlessly on various platforms including Linux and Mac OS.|
|TR08|Database|The system must utilize the PostgreSQL database management system, with a minimum version of 11.|
|TR09|Robustness|The system should be resilient and capable of maintaining its functionality even in the face of unexpected runtime errors or disruptions.|
|TR10|Scalability|The system must be designed to accommodate the growth in user numbers and their interactions effectively.|
|TR11|Ethics|The system must uphold ethical standards in software development, ensuring that personal user information and usage data are neither collected nor shared without explicit consent and authorization from their owners.|

Table 9: The Popcorn Post's technical requirements

#### 3\.3. Restrictions

|Identifier|Name|Description|
|---|---|---|
|C01|Deadline|The system should be fully operational by the end of the year, allowing cinema enthusiasts to engage in discussions and access news related to the Oscars and Emmys during the awards season.|

Table 10: The Popcorn Post's restrictions

---

## A3: Information Architecture

This artefact provides a concise overview of the information architecture for the upcoming system development. Its objectives encompass:

1. Facilitating the identification and description of user requirements, including the discovery of any new ones.
2. Offering a preview and empirical testing of the forthcoming product's user interface.
3. Enabling rapid, iterative design improvements to the user interface.

This artefact consists of two key components:

1. **Sitemap**: This outlines the organisational structure of information across various pages, aiding in visualising how data and content are arranged.
2. **Wireframes**: These serve as blueprints for individual pages, specifying both functionality and content. Wireframes were created for two of the most pivotal pages in the system.


### 1\. Sitemap

A sitemap is a visual representation that illustrates the interconnections among the different web pages of a site. It provides a comprehensive overview of the planned pages, offering a top-level perspective on how the information within the website is structured and organized.

The Popcorn Post information system is structured into six primary categories:

- **General Information Pages**: These pages offer comprehensive information about the system in a general context.
- **Authentication Pages**: This section encompasses pages dedicated to user registration and login processes.
- **User Pages**: Within this category, you'll find pages associated with Member Profiles and user settings.
- **Search Page**: This is the hub for conducting searches and viewing search results.  
- **News-Related Pages**: Explore, curate, and create news content, or delve into various themes within this section.
- **Administration Pages**: These pages house administrative functionalities, catering to system management and control.

![sitemap](uploads/b192e076fe160f82a1e0c07f01624f3b/sitemap.jpg)

Figure 2: The Popcorn Post's sitemap.

### 2\. Wireframes

#### UI01: Homepage

![home_page_wireframe](uploads/1455f75a4f8d59b8f40618ecb5438846/home_page_wireframe.jpg)

Figure 3: The Popcorn Post's homepage wireframe.

#### UI12: News Page

![news_page_wireframe](uploads/0a28be298dcb60522af6d29c57b1d889/news_page_wireframe.jpg)

Figure 4: The Popcorn Post's news page wireframe.

---

## Revision history

Changes made to the first submission:

1. Item 1
1. ...

---

GROUP2356, 03/10/2023

* Tiago Filipe Castro Viana, up201807126@up.pt (Editor)
* João Filipe Oliveira Ramos, up202108743@up.pt
* Marco André Pereira da Costa, up202108821@up.pt
* Diogo Alexandre Figueiredo Gomes, up201905991@up.pt