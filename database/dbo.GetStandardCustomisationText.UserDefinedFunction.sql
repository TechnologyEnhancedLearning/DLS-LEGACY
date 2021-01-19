USE [mbdbx101]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hugh Gibson
-- Create date: 9th September 2010
-- Description:	Gives standard Customisation text for Elite
-- =============================================
CREATE FUNCTION [dbo].[GetStandardCustomisationText]
(
)
RETURNS varchar(max)
AS
BEGIN
	RETURN '[#FolderPath: "Save Data\", #volume: 100, #MailAddress: "", #TextColor: "Default", #TextBkgColor: "Default", #fontSize: 14, #Office: 2003, #VO: 1, #AssessOn: 1, #LearnOn: 1, #AssessSelect: 1, #PLAssess:1, #LearnThresh:0, #DiagThresh:90, #ContentList: [[#Section: 0, #SecName: "How to use these tutorials", "LearnOn": 1, "AssessOn": 0, #Objectives: [[#ObjNum: 0, #ObjName: "How to use these tutorials", "LearnOn": 1, #AssessOn: 0, #AssessOutOf: 0, #LearnMins: 5, #AssessSecs: 0]]], [#Section: 1, #SecName: "Mouse skills", "LearnOn": 1, "AssessOn": 1, #Objectives: [[#ObjNum: 1, #ObjName: "Pointing devices", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 4, #LearnMins: 5, #AssessSecs: 30], [#ObjNum: 2, #ObjName: "Moving the mouse and clicking", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 10, #AssessSecs: 20], [#ObjNum: 3, #ObjName: "Double clicking", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 5, #AssessSecs: 20], [#ObjNum: 4, #ObjName: "Dragging", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 8, #AssessSecs: 30], [#ObjNum: 5, #ObjName: "Scrolling", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 6, #AssessSecs: 20], [#ObjNum: 6, #ObjName: "Right clicking", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 6, #AssessSecs: 25], [#ObjNum: 89, #ObjName: "Drawing*", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 10, #AssessSecs: 40]]], [#Section: 2, #SecName: "Keyboard skills", "LearnOn": 1, "AssessOn": 1, #Objectives: [[#ObjNum: 7, #ObjName: "Text entry devices", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 4, #LearnMins: 5, #AssessSecs: 30], [#ObjNum: 8, #ObjName: "Letters and numbers", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 3, #LearnMins: 10, #AssessSecs: 180], [#ObjNum: 9, #ObjName: "Capital letters", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 3, #LearnMins: 5, #AssessSecs: 180], [#ObjNum: 10, #ObjName: "The text entry cursor", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 6, #AssessSecs: 40], [#ObjNum: 11, #ObjName: "Punctuation and symbols", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 10, #LearnMins: 6, #AssessSecs: 120], [#ObjNum: 12, #ObjName: "The Return key", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 5, #AssessSecs: 30], [#ObjNum: 13, #ObjName: "Backspace and Delete", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 5, #AssessSecs: 30], [#ObjNum: 14, #ObjName: "The Tab key", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 4, #AssessSecs: 45], [#ObjNum: 15, #ObjName: "Useful keys / key combinations", "LearnOn": 1, "AssessOn": 0, #AssessOutOf: 0, #LearnMins: 4, #AssessSecs: 0]]], [#Section: 3, #SecName: "Switching on and off", "LearnOn": 1, "AssessOn": 1, #Objectives: [[#ObjNum: 16, #ObjName: "Power switches and switching on", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 3, #AssessSecs: 40], [#ObjNum: 17, #ObjName: "Logging on", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 5, #AssessSecs: 45], [#ObjNum: 18, #ObjName: "Changing your password", "LearnOn": 1, "AssessOn": 0, #AssessOutOf: 0, #LearnMins: 5, #AssessSecs: 0], [#ObjNum: 19, #ObjName: "Smartcards", "LearnOn": 1, "AssessOn": 0, #AssessOutOf: 0, #LearnMins: 3, #AssessSecs: 0], [#ObjNum: 20, #ObjName: "Locking the computer", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 3, #LearnMins: 5, #AssessSecs: 30], [#ObjNum: 21, #ObjName: "Logging off", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 3, #AssessSecs: 40], [#ObjNum: 22, #ObjName: "Restarting", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 3, #AssessSecs: 30], [#ObjNum: 23, #ObjName: "Shutting down", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 3, #AssessSecs: 30]]], [#Section: 4, #SecName: "Using Windows", "LearnOn": 1, "AssessOn": 1, #Objectives: [[#ObjNum: 24, #ObjName: "The Desktop", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 6, #LearnMins: 5, #AssessSecs: 40], [#ObjNum: 25, #ObjName: "The Start Menu", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 4, #AssessSecs: 30], [#ObjNum: 26, #ObjName: "Parts of a window", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 5, #LearnMins: 5, #AssessSecs: 40], [#ObjNum: 27, #ObjName: "Maximise, minimise, close, restore", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 10, #LearnMins: 8, #AssessSecs: 60], [#ObjNum: 28, #ObjName: "Moving a window", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 4, #AssessSecs: 30], [#ObjNum: 29, #ObjName: "Resizing a window", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 4, #AssessSecs: 30]]], [#Section: 5, #SecName: "Working with applications", "LearnOn": 1, "AssessOn": 1, #Objectives: [[#ObjNum: 30, #ObjName: "Applications", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 6, #LearnMins: 7, #AssessSecs: 40], [#ObjNum: 31, #ObjName: "Starting applications", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 5, #LearnMins: 7, #AssessSecs: 30], [#ObjNum: 32, #ObjName: "Toolbars", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 7, #AssessSecs: 20], [#ObjNum: 33, #ObjName: "Menus", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 7, #AssessSecs: 25], [#ObjNum: 88, #ObjName: "The application ribbon", "LearnOn": 0, "AssessOn": 0, #AssessOutOf: 2, #LearnMins: 8, #AssessSecs: 30], [#ObjNum: 34, #ObjName: "Context menus", "LearnOn": 1, "AssessOn": 0, #AssessOutOf: 0, #LearnMins: 7, #AssessSecs: 0], [#ObjNum: 35, #ObjName: "Working with dialogue boxes", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 3, #LearnMins: 12, #AssessSecs: 45], [#ObjNum: 36, #ObjName: "Save and Save as", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 18, #AssessSecs: 45], [#ObjNum: 37, #ObjName: "Opening files", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 12, #AssessSecs: 25], [#ObjNum: 38, #ObjName: "Page Setup and printing", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 3, #LearnMins: 12, #AssessSecs: 40], [#ObjNum: 39, #ObjName: "Accessing Help", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 12, #AssessSecs: 20], [#ObjNum: 40, #ObjName: "Switching between windows", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 7, #AssessSecs: 25], [#ObjNum: 41, #ObjName: "Selecting text", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 3, #LearnMins: 12, #AssessSecs: 30], [#ObjNum: 42, #ObjName: "Overtyping", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 7, #AssessSecs: 30], [#ObjNum: 43, #ObjName: "Cut, Copy and Paste", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 18, #AssessSecs: 40], [#ObjNum: 44, #ObjName: "Using Undo", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 7, #AssessSecs: 20], [#ObjNum: 45, #ObjName: "Working with tables", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 3, #LearnMins: 18, #AssessSecs: 45], [#ObjNum: 46, #ObjName: "Using Task Manager", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 3, #LearnMins: 12, #AssessSecs: 40]]], [#Section: 6, #SecName: "File management", "LearnOn": 1, "AssessOn": 1, #Objectives: [[#ObjNum: 47, #ObjName: "The filing system", "LearnOn": 1, "AssessOn": 0, #AssessOutOf: 0, #LearnMins: 12, #AssessSecs: 0], [#ObjNum: 48, #ObjName: "The My Computer window", "LearnOn": 1, "AssessOn": 0, #AssessOutOf: 0, #LearnMins: 7, #AssessSecs: 15], [#ObjNum: 49, #ObjName: "Changing views", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 7, #AssessSecs: 30], [#ObjNum: 50, #ObjName: "Locating your network drive", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 7, #AssessSecs: 30], [#ObjNum: 51, #ObjName: "Working with folder Explorer view", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 12, #AssessSecs: 25], [#ObjNum: 52, #ObjName: "Finding files and folders", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 12, #AssessSecs: 45], [#ObjNum: 53, #ObjName: "Sorting files", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 7, #AssessSecs: 30], [#ObjNum: 54, #ObjName: "Creating folders", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 3, #LearnMins: 12, #AssessSecs: 40], [#ObjNum: 55, #ObjName: "Moving and copying files", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 18, #AssessSecs: 30], [#ObjNum: 56, #ObjName: "Renaming files and folders", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 8, #AssessSecs: 30], [#ObjNum: 57, #ObjName: "Deleting files", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 7, #AssessSecs: 30], [#ObjNum: 58, #ObjName: "Restoring files from the Recycle Bin", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 6, #AssessSecs: 30], [#ObjNum: 59, #ObjName: "Emptying the Recycle Bin", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 5, #AssessSecs: 25]]], [#Section: 7, #SecName: "Web skills", "LearnOn": 1, "AssessOn": 1, #Objectives: [[#ObjNum: 60, #ObjName: "Introducing Web browsers", "LearnOn": 1, "AssessOn": 0, #AssessOutOf: 0, #LearnMins: 5, #AssessSecs: 0], [#ObjNum: 61, #ObjName: "Using Web addresses", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 8, #AssessSecs: 30], [#ObjNum: 62, #ObjName: "Finding and following links", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 7, #AssessSecs: 25], [#ObjNum: 63, #ObjName: "Searching the Web", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 8, #AssessSecs: 30], [#ObjNum: 64, #ObjName: "Using Web forms", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 5, #LearnMins: 12, #AssessSecs: 40]]], [#Section: 8, #SecName: "E-mail skills", "LearnOn": 1, "AssessOn": 1, #Objectives: [[#ObjNum: 65, #ObjName: "Introducing e-mail", "LearnOn": 1, "AssessOn": 0, #AssessOutOf: 0, #LearnMins: 5, #AssessSecs: 0], [#ObjNum: 66, #ObjName: "Opening and closing messages", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 3, #LearnMins: 6, #AssessSecs: 40], [#ObjNum: 67, #ObjName: "Replying and forwarding", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 5, #LearnMins: 8, #AssessSecs: 60], [#ObjNum: 68, #ObjName: "Sending messages", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 5, #LearnMins: 8, #AssessSecs: 60], [#ObjNum: 69, #ObjName: "Deleting messages", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 5, #AssessSecs: 30], [#ObjNum: 70, #ObjName: "Emptying Deleted Items", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 4, #AssessSecs: 30], [#ObjNum: 71, #ObjName: "Sorting messages", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 8, #AssessSecs: 40], [#ObjNum: 72, #ObjName: "Organising messages", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 12, #AssessSecs: 40], [#ObjNum: 73, #ObjName: "Creating Contacts", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 3, #LearnMins: 12, #AssessSecs: 50], [#ObjNum: 74, #ObjName: "Using the Address Book", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 4, #LearnMins: 12, #AssessSecs: 50], [#ObjNum: 75, #ObjName: "Working with attachments", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 4, #LearnMins: 12, #AssessSecs: 60], [#ObjNum: 76, #ObjName: "Adding attachments", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 8, #AssessSecs: 45]]], [#Section: 9, #SecName: "Word processing +", "LearnOn": 1, "AssessOn": 1, #Objectives: [[#ObjNum: 77, #ObjName: "Introduction to Word Processing", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 5, #LearnMins: 6, #AssessSecs: 30], [#ObjNum: 78, #ObjName: "Working with Templates", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 3, #LearnMins: 12, #AssessSecs: 50], [#ObjNum: 79, #ObjName: "Text formatting", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 5, #LearnMins: 15, #AssessSecs: 50], [#ObjNum: 80, #ObjName: "Layout formatting", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 7, #LearnMins: 15, #AssessSecs: 60], [#ObjNum: 81, #ObjName: "Finding and replacing text", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 7, #AssessSecs: 30], [#ObjNum: 82, #ObjName: "Page layout", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 9, #AssessSecs: 40], [#ObjNum: 83, #ObjName: "Inserting pictures and objects", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 2, #LearnMins: 15, #AssessSecs: 45], [#ObjNum: 84, #ObjName: "Spell checking and proof-reading", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 6, #AssessSecs: 30]]], [#Section: 10, #SecName: "Working safely +", "LearnOn": 1, "AssessOn": 1, #Objectives: [[#ObjNum: 85, #ObjName: "Understanding the risks", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 4, #LearnMins: 10, #AssessSecs: 30], [#ObjNum: 86, #ObjName: "Setting up your workstation", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 1, #LearnMins: 14, #AssessSecs: 40], [#ObjNum: 87, #ObjName: "Routine maintenance", "LearnOn": 1, "AssessOn": 1, #AssessOutOf: 4, #LearnMins: 6, #AssessSecs: 30]]]]]'
END
GO
