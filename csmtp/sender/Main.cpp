#include <unordered_map>
#include <iostream>
#include <sstream>

#include "../csmtp/CSmtp.h"

int main(int argc, char* argv[])
{
    std::unordered_map<std::string, std::string> mailInfos;
    ///////////////////////////////////////////////////////
    mailInfos["ServerName"] = "";       // Required
    mailInfos["ServerPort"] = "25";     // Configuration
    ///////////////////////////////////////////////////////
    mailInfos["Security"] = "none";     // Configuration
    ///////////////////////////////////////////////////////
    mailInfos["User"] = "";             // Required
    mailInfos["Password"] = "";         // Required
    ///////////////////////////////////////////////////////
    mailInfos["SenderName"] = "";       // Required
    mailInfos["SenderMail"] = "";       // Required
    ///////////////////////////////////////////////////////
    mailInfos["ReceiverMails"] = "";    // Required
    ///////////////////////////////////////////////////////
    mailInfos["Title"] = "";            // Required
    mailInfos["Body"] = "";             // Required
    ///////////////////////////////////////////////////////
    mailInfos["Files"] = "";            // Optional
    ///////////////////////////////////////////////////////
    mailInfos["CharSet"] = "gb2312";    // Configuration
    mailInfos["XMailer"] = "ms_v3.0";   // Optional
    mailInfos["XPriority"] = "normal";  // Optional
    ///////////////////////////////////////////////////////
    mailInfos["Output"] = "true";       // Optional
    ///////////////////////////////////////////////////////
    for (int argn = 1; argn < argc; argn++) {
        std::string info(argv[argn]);
        size_t split = info.find_first_of('=');
        std::string key = info.substr(0, split);
        std::string value = info.substr(split + 1);
        mailInfos[key] = value;
    }

    bool error = false;
    try {
        CSmtp mail;

        mail.SetSMTPServer(mailInfos["ServerName"].c_str(),
            atoi(mailInfos["ServerPort"].c_str()));

        if (mailInfos["Security"] == "none") {
            mail.SetSecurityType(NO_SECURITY);
        } else if (mailInfos["Security"] == "tls") {
            mail.SetSecurityType(USE_TLS);
        } else if (mailInfos["Security"] == "ssl") {
            mail.SetSecurityType(USE_SSL);
        } else {
            mail.SetSecurityType(DO_NOT_SET);
        }

        mail.SetLogin(mailInfos["User"].c_str());
        mail.SetPassword(mailInfos["Password"].c_str());

        mail.SetSenderName(mailInfos["SenderName"].c_str());
        mail.SetSenderMail(mailInfos["SenderMail"].c_str());

        std::stringstream receivers(mailInfos["ReceiverMails"]);
        while (!receivers.eof()) {
            std::string receiver;
            receivers >> receiver;
            if (!receiver.empty()) {
                mail.AddRecipient(receiver.c_str());
            }
        }

        mail.SetSubject(mailInfos["Title"].c_str());
        mail.AddMsgLine(mailInfos["Body"].c_str());

        std::stringstream attachments(mailInfos["Files"]);
        while (!attachments.eof()) {
            std::string attachment;
            attachments >> attachment;
            if (!attachment.empty()) {
                mail.AddAttachment(attachment.c_str());
            }
        }

        mail.SetCharSet(mailInfos["CharSet"].c_str());
        mail.SetXMailer(mailInfos["XMailer"].c_str());
        if (mailInfos["XPriority"] == "normal") {
            mail.SetXPriority(XPRIORITY_NORMAL);
        } else if (mailInfos["XPriority"] == "high") {
            mail.SetXPriority(XPRIORITY_HIGH);
        } else if (mailInfos["XPriority"] == "low") {
            mail.SetXPriority(XPRIORITY_LOW);
        } else {
            mail.SetXPriority(XPRIORITY_NORMAL);
        }

        mail.Send();

        if (mailInfos["Output"] == "true") {
            std::cout << mail.GetLastOutput() << std::endl;
        }
        mail.ClearMessage(); // Clear mail content and last output.

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
