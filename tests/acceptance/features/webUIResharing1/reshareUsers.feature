# Reshare permission is not available now in the oCIS webUI
Feature: Resharing shared files with different permissions
  As a user
  I want to reshare received files and folders with other users with different permissions
  So that I can control the access on those files/folders by other collaborators

  Background:
    Given the setting "shareapi_auto_accept_share" of app "core" has been set to "no" in the server
    And the administrator has set the default folder for received shares to "Shares" in the server
    And these users have been created with default attributes and without skeleton files in the server:
      | username |
      | Alice    |
      | Brian    |
      | Carol    |
    And user "Brian" has created folder "simple-folder" in the server

  # this scenario is skipped on ocis because it opens share folder which in not possible in OCIS
  # but it works for OC10 see issue https://github.com/owncloud/web/issues/6896 for more detail
  @skipOnOCIS
  Scenario: share a folder with another user with share permissions and reshare without share permissions to different user, and check if user is displayed for original sharer
    Given user "Brian" has shared folder "simple-folder" with user "Alice" with "read, share" permissions in the server
    And user "Alice" has accepted the share "Shares/simple-folder" offered by user "Brian" in the server
    And user "Alice" has logged in using the webUI
    And the user opens folder "Shares" using the webUI
    When the user shares folder "simple-folder" with user "Carol King" as "Custom permissions" with permissions "," using the webUI
    And user "Carol" accepts the share "Shares/simple-folder" offered by user "Alice" using the sharing API in the server
    And the user re-logs in as "Brian" using the webUI
    Then user "Carol King" should be listed as "Custom permissions" in the collaborators list for folder "simple-folder" on the webUI
    And no custom permissions should be set for collaborator "Carol King" for folder "simple-folder" on the webUI
    And user "Alice Hansen" should be listed as "Can view" in the collaborators list for folder "simple-folder" on the webUI
    And user "Alice" should have received a share with these details in the server:
      | field       | value                 |
      | uid_owner   | Brian                 |
      | share_with  | Alice                 |
      | file_target | /Shares/simple-folder |
      | item_type   | folder                |
      | permissions | read, share           |
    And user "Carol" should have received a share with these details in the server:
      | field       | value                 |
      | uid_owner   | Alice                 |
      | share_with  | Carol                 |
      | file_target | /Shares/simple-folder |
      | item_type   | folder                |
      | permissions | read                  |

  # this scenario is skipped on ocis because it opens share folder which in not possible in OCIS
  # but it works for OC10 see issue https://github.com/owncloud/web/issues/6896 for more detail
  @skipOnOCIS
  Scenario: share a folder with another user with share permissions and reshare without share permissions to different user, and check if user is displayed for the receiver
    Given user "Brian" has shared folder "simple-folder" with user "Alice" with "read, share" permissions in the server
    And user "Alice" has accepted the share "Shares/simple-folder" offered by user "Brian" in the server
    And user "Alice" has logged in using the webUI
    And the user opens folder "Shares" using the webUI
    When the user shares folder "simple-folder" with user "Carol King" as "Viewer" with permissions "," using the webUI
    And user "Carol" accepts the share "Shares/simple-folder" offered by user "Alice" using the sharing API in the server
    And user "Carol" should have received a share with these details in the server:
      | field       | value                 |
      | uid_owner   | Alice                 |
      | share_with  | Carol                 |
      | file_target | /Shares/simple-folder |
      | item_type   | folder                |
      | permissions | read, share           |

  @skipOnOCIS
  Scenario: share a folder without share permissions and check if another user can reshare
    Given user "Brian" has shared folder "simple-folder" with user "Alice" with "read" permissions in the server
    And user "Alice" has accepted the share "Shares/simple-folder" offered by user "Brian" in the server
    When user "Alice" logs in using the webUI
    And the user opens folder "Shares" using the webUI
    Then the user should not be able to share resource "simple-folder" using the webUI

  @skipOnOCIS
  Scenario: share a file without share permissions and check if another user can reshare
    Given user "Brian" has created file "lorem.txt" in the server
    And user "Brian" has shared file "lorem.txt" with user "Alice" with "read" permissions in the server
    And user "Alice" has accepted the share "Shares/lorem.txt" offered by user "Brian" in the server
    When user "Alice" logs in using the webUI
    And the user opens folder "Shares" using the webUI
    Then the user should not be able to share resource "lorem.txt" using the webUI

  @skipOnOCIS
  Scenario: share a received folder without share permissions and check if another user can reshare
    Given user "Brian" has shared folder "simple-folder" with user "Alice" with "all" permissions in the server
    And user "Alice" has accepted the share "Shares/simple-folder" offered by user "Brian" in the server
    And user "Alice" has shared folder "/Shares/simple-folder" with user "Carol" with "read" permissions in the server
    And user "Carol" has accepted the share "Shares/simple-folder" offered by user "Alice" in the server
    When user "Carol" logs in using the webUI
    And the user opens folder "Shares" using the webUI
    Then the user should not be able to share resource "simple-folder" using the webUI

  @skipOnOCIS
  Scenario: share a received file without share permissions and check if another user can reshare
    Given user "Brian" has created file "lorem.txt" in the server
    And user "Brian" has shared file "lorem.txt" with user "Alice" with "all" permissions in the server
    And user "Alice" has accepted the share "Shares/lorem.txt" offered by user "Brian" in the server
    And user "Alice" has shared folder "/Shares/lorem.txt" with user "Carol" with "read" permissions in the server
    And user "Carol" has accepted the share "Shares/lorem.txt" offered by user "Alice" in the server
    When user "Carol" logs in using the webUI
    And the user opens folder "Shares" using the webUI
    Then the user should not be able to share resource "lorem.txt" using the webUI

  @skipOnOCIS
  Scenario: User is allowed to reshare a file/folder with the equivalent received permissions, and collaborators should not be listed for the receiver
    Given user "Brian" has shared folder "simple-folder" with user "Alice" with "read, share, delete" permissions in the server
    And user "Alice" has accepted the share "Shares/simple-folder" offered by user "Brian" in the server
    And user "Alice" has logged in using the webUI
    And the user opens folder "Shares" using the webUI
    When the user shares folder "simple-folder" with user "Carol King" as "Custom permissions" with permissions "share, delete" using the webUI
    And user "Carol" accepts the share "Shares/simple-folder" offered by user "Alice" using the sharing API in the server
    And the user re-logs in as "Carol" using the webUI
    And the user opens folder "Shares" using the webUI
    And the collaborators list for folder "simple-folder" should be empty
    # Then the current collaborators list should have order "Brian Murphy,Carol King"
    # And user "Brian Murphy" should be listed as "Owner" reshared through "Alice Hansen" in the collaborators list on the webUI
    And user "Carol" should have received a share with these details in the server:
      | field       | value                 |
      | uid_owner   | Alice                 |
      | share_with  | Carol                 |
      | file_target | /Shares/simple-folder |
      | item_type   | folder                |
      | permissions | share, delete, read   |

  @skipOnOCIS
  Scenario: User is allowed to reshare a file/folder with the lesser permissions, and check if it is listed for original owner
    Given user "Brian" has shared folder "simple-folder" with user "Alice" with "read, share, delete" permissions in the server
    And user "Alice" has accepted the share "Shares/simple-folder" offered by user "Brian" in the server
    And user "Alice" has logged in using the webUI
    And the user opens folder "Shares" using the webUI
    When the user shares folder "simple-folder" with user "Carol King" as "Custom permissions" with permissions "delete" using the webUI
    And user "Carol" accepts the share "Shares/simple-folder" offered by user "Alice" using the sharing API in the server
    And the user re-logs in as "Brian" using the webUI
    Then user "Alice Hansen" should be listed as "Custom permissions" in the collaborators list for folder "simple-folder" on the webUI
    And custom permissions "share, delete" should be set for user "Alice Hansen" for folder "simple-folder" on the webUI
    And user "Carol King" should be listed as "Custom permissions" in the collaborators list for folder "simple-folder" on the webUI
    And custom permissions "delete" should be set for user "Carol King" for folder "simple-folder" on the webUI
    And user "Carol" should have received a share with these details in the server:
      | field       | value                 |
      | uid_owner   | Alice                 |
      | share_with  | Carol                 |
      | file_target | /Shares/simple-folder |
      | item_type   | folder                |
      | permissions | delete, read          |

  @skipOnOCIS
  Scenario: Reshare a file and folder from shared with me page
    Given user "Brian" has created file "lorem.txt" in the server
    And user "Brian" has shared folder "simple-folder" with user "Alice" in the server
    And user "Alice" has accepted the share "Shares/simple-folder" offered by user "Brian" in the server
    And user "Brian" has shared file "lorem.txt" with user "Alice" in the server
    And user "Alice" has accepted the share "Shares/lorem.txt" offered by user "Brian" in the server
    And user "Alice" has logged in using the webUI
    And the user has browsed to the shared-with-me page
    When the user shares folder "simple-folder" with user "Carol King" as "Editor" using the webUI
    And the user shares file "lorem.txt" with user "Carol King" as "Editor" using the webUI
    And user "Carol" accepts the share "Shares/simple-folder" offered by user "Alice" using the sharing API in the server
    And user "Carol" accepts the share "Shares/lorem.txt" offered by user "Alice" using the sharing API in the server
    Then as "Carol" folder "/Shares/simple-folder" should exist in the server
    And as "Carol" file "/Shares/lorem.txt" should exist in the server


  Scenario: Reshare a file and folder from shared with others page
    Given user "Brian" has created file "lorem.txt" in the server
    And user "Brian" has shared folder "simple-folder" with user "Alice" in the server
    And user "Alice" has accepted the share "Shares/simple-folder" offered by user "Brian" in the server
    And user "Brian" has shared file "lorem.txt" with user "Alice" in the server
    And user "Alice" has accepted the share "Shares/lorem.txt" offered by user "Brian" in the server
    And user "Brian" has logged in using the webUI
    And the user has browsed to the shared-with-others page
    When the user shares folder "simple-folder" with user "Carol King" as "Editor" using the webUI
    And the user shares file "lorem.txt" with user "Carol King" as "Editor" using the webUI
    And user "Carol" accepts the share "Shares/simple-folder" offered by user "Brian" using the sharing API in the server
    And user "Carol" accepts the share "Shares/lorem.txt" offered by user "Brian" using the sharing API in the server
    Then as "Carol" folder "/Shares/simple-folder" should exist in the server
    And as "Carol" file "/Shares/lorem.txt" should exist in the server

  @issue-ocis-1330
  Scenario: Reshare a file and folder from favorites page
    Given user "Brian" has created file "lorem.txt" in the server
    And user "Brian" has shared folder "simple-folder" with user "Alice" in the server
    And user "Alice" has accepted the share "Shares/simple-folder" offered by user "Brian" in the server
    And user "Brian" has shared file "lorem.txt" with user "Alice" in the server
    And user "Alice" has accepted the share "Shares/lorem.txt" offered by user "Brian" in the server
    And user "Alice" has favorited element "/Shares/simple-folder" in the server
    And user "Alice" has favorited element "/Shares/lorem.txt" in the server
    And user "Alice" has logged in using the webUI
    When the user browses to the favorites page using the webUI
    And the user shares folder "Shares/simple-folder" with user "Carol King" as "Editor" using the webUI
    And the user shares file "Shares/lorem.txt" with user "Carol King" as "Editor" using the webUI
    And user "Carol" accepts the share "Shares/simple-folder" offered by user "Alice" using the sharing API in the server
    And user "Carol" accepts the share "Shares/lorem.txt" offered by user "Alice" using the sharing API in the server
    Then as "Carol" folder "/Shares/simple-folder" should exist in the server
    And as "Carol" file "/Shares/lorem.txt" should exist in the server

  @issue-product-270
  Scenario: Resource owner sees resharer in collaborators list
    Given user "Brian" has created file "lorem.txt" in the server
    And user "Brian" has shared folder "simple-folder" with user "Alice" in the server
    And user "Alice" has accepted the share "Shares/simple-folder" offered by user "Brian" in the server
    And user "Alice" has shared folder "/Shares/simple-folder" with user "Carol" in the server
    And user "Carol" has accepted the share "Shares/simple-folder" offered by user "Alice" in the server
    When user "Brian" has logged in using the webUI
    And the user opens the share dialog for folder "simple-folder" using the webUI
    Then user "Alice Hansen" should be listed as "Can edit" in the collaborators list on the webUI
    And user "Carol King" should be listed as "Can edit" in the collaborators list on the webUI
