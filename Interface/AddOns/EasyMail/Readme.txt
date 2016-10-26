EasyMail 3.0.3

by Yarko

Description
-----------
Modifications to the World of Warcraft mail frame.

- For each character, remembers the last addressee to whom mail was sent and defaults that name into the addressee field when a new blank mail is displayed.

- Remembers a user-configurable number of recently-mailed addressees by realm, and allows the player to select from the list to fill in the addressee field by clicking on a drop-down button displayed to the right of the addressee field. If the list is at maximum length, the addressee least recently mailed is removed to add a new addressee. Right-clicking a name in the drop-down list prompts the user to delete that name from the addressee list.

- Names from the player's friends list and members of the player's guild can be displayed in the addressee drop-down list by setting the appropriate options.

- Automatically fills in the mail subject line if it is empty when entering money to send.

- A Take All button is added to the Open Mail window that allows the player to move all the item and money attachments for the open mail into the player's bags with a single click. This button is disabled on COD mails until the user clicks one item and confirms the COD. The button will not take existing mail text as an attachment. The Take All process will time out if it is unable to take an attachment for 8 seconds.  Closing the mail window will also cancel the process.

- A Get Attachments button is added to the inbox that allows the user to get all attachments from all mails that have been selected using checkboxes positioned to the left of each mail entry. A second button has been added to the inbox that allows the user to either mark or clear all mails for attachment retrieval. COD mails will be ignored until the COD is confirmed manually for each mail by the user. To cancel the attachment retrieval process, close the mailbox.

- Right-click attachment retrieval and mail deletion from the inbox. Right-clicking a mail item with attachments in the inbox will cause the take all process to attempt to retrieve all attachments from the mail. If the mail has text but no attachments, right-clicking will delete the mail. If the mail has both attachments and text, right-clicking will cause the take all to retrieve the attachments. Then, right-clicking again will delete the mail. The right-click does not affect COD mails until after the user chooses to accept the COD manually. The user can opt to disable the deletion prompt for mails marked as read. EasyMail will always prompt on the deletion of unread mails.

- Displays mail text in the inbox item tooltip. WARNING: Mails will be immediately marked as read once the tooltip has been displayed. Due to Blizzard's API design, mail text may take a few seconds to appear in the tooltip.


Slash commands
--------------
/easymail setlen <n> - Sets the maximum length of the addressee list for the current realm to the number substituted for n. If the maximum length is set to a number smaller than the current number of entries in the list, the oldest entries are removed. 

/easymail clearlist - Removes all entries in the addressee list on the current realm. 

/easymail autoadd <ON/OFF> - Automatically add logged-in characters to the addressee list. 

/easymail friends <ON/OFF> - Display friend names in the addressee drop-down list

/easymail guild <ON/OFF> - Display guild member names in the addressee drop-down list

/easymail clickget <ON/OFF> - Right-click retrieval of mail attachments from the inbox

/easymail clickdel <ON/OFF> - Right-click deletion of mail from the inbox

/easymail delprompt <ON/OFF> - Prompt for deletion of read mail when right-clicking

/easymail tooltip <ON/OFF> - Display mail text in the inbox item tooltip

/easymail delpending <ON/OFF> - Delete pending auction mails when getting all attachments

/easymail money <ON/OFF> - Output money received per mail to chat window

/easymail total <ON/OFF> - Output total money received from mail to chat window when getting all attachments


Timeout Error Message
---------------------
On occasion, the player might see the error text, "Unable to retrieve an attachment for 10 seconds. Check available bag space or unique items. If you are having internet latency problems, please try the Take All process again at another time." This is a generic error that occurs when the automatic take all process is unable to remove an attachment after trying for 10 seconds. When this happens, the process is canceled. The most likely cause of this error is the player not having enough bag space to store the attachments. The error might also occur if there is significant network lag or if the player does something peculiar with his mail windows while the get all process is running. When the error occurs, make sure the player has enough bag space or waits a bit and then tries the process again.


