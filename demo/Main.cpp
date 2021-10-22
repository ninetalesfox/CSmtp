#include <iostream>
#include "CSmtp.h"

int main()
{
    bool error = false;
    try {
        CSmtp mail;

        mail.SetSMTPServer("smtp.office365.com");
        mail.SetSecurityType(USE_TLS);

        mail.SetLogin("[your outlook mail user]");
        mail.SetPassword("[your outlook mail password]");

        mail.SetSenderName("[your current mail's sender name]");
        mail.SetSenderMail("[your current mail's sender mail address]");

        mail.AddRecipient("[your current mail's receiver mail address]");
        // mail.AddRecipient("[another receiver mail address...]");

        mail.SetSubject("[This is mail title]");
        mail.AddMsgLine("[This is mail content]");
        // mail.AddMsgLine("[This is mail content, and add one line]");
        // mail.DelMsgLine(1); // Delete the mail content line:1

        // mail.AddAttachment("[Add mail attachment (file)]"); // should <25MB

        mail.SetCharSet("gb2312");
        mail.SetXMailer("csmtp_v3");
        mail.SetXPriority(XPRIORITY_NORMAL);

        mail.Send(); // Wow! Send mail!

        std::cout << mail.GetLastOutput() << std::endl;

        // Clear mail content and last output, then you can fill
        // with a new mail and send it.
        mail.ClearMessage();

        std::cout << std::endl << "##### SEND MAIL #####" << std::endl;
    } catch(ECSmtp e) {
        error = true;
        std::cout << "- Error: " << e.GetErrorText() << std::endl;
    }
    if (!error) {
        std::cout << "- Success!" << std::endl;
    }

    return 0;
}
