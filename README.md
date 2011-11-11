# FileDrop

## User Information

### About

FileDrop is a simple Mac client that communicates with a KBProxyServer to allow two cilents to communicate and exchange files.

### Purpose

FileDrop's main purpose is to allow easy transfer resumes. Simply start the transfer again, pick the same save location and the transfer will resume rather than start over. Some applications for file transfer seem to fail at this, and for large files that is annoying, and unexcusable. 




## Developer goodies/notes

Each FileDrop window communicates directly with an instance of FDFileManager. When the window is created you need to ask the user for a token (passphrase) which the server will use to pair up with another client. Each FDFileManager is to have it's own unique token and window. The server will return an error if the token is in use already (by two other clients). 

A file object (FDFile) is either an instance of FDFileRecv (downloading) or FDFileSend (uploading). These two groups are to be separated in different sections of the tableview. To send a file, a user should simply drop it into the table. At this point you would tell the window's FDFileManager to send this file. To do this simply supply the file path. 


### FDFileManager

Although confusing at first, FDFileManager pretends to manage sections itself. Simply put there are 2 sections (-numberOfSections), one section for downloads and one for uploads. However to make delegation easy (to alert you to where a file is being added) I decided to use "sections". Just play along and use my section methods. Who knows, maybe they'll be more useful in the future. 


### Communication packets

Within each "data" field of a given KB object, here are some examples

    ["type": "file", "id": <STRING_ID>, "action": <STRING_METHOD>, …]

The ID is a string, generally randomized by the sender, that will reference this specific file transfer. 


Here are possible actions you will see:

- "init": Creating a new transfer
- "update": Tell a client where to begin sending a file that is not accepted *yet*
- "accept": Accepting a new transfer that was just init'd
- "cancel": Canceling a transfer that has already been accept'd
- "data": Data for a file that has been accepted and is downloading

