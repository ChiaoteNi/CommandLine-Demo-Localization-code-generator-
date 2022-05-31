# SwiftCommandLineTool

## Descriptions:
It's a demo code to make a Swift command line tool for auto-generating Localization strings and the related code from Google Sheets.
Since this project is only for the demo, all the detailed work that is unnecessary for this goal was not implemented.
Ex: handling escape characters, localized string with format, error handling ... etc.

So please don't use this code for your project directly. It's just for demo, which implemented the main flow but did not implement all other required functions for generating the Localization string.

However, please feel free to move partial code from this project to make your own auto-generating command line tool.
I mention not to use it directly just because it doesn't work enough for a production code level.

## How to use it?
- I have separated each part into different commits. 
  You can check out each commit step by step to get how I made it:

  - How to call api in Swift Command Line Tool
  - Code / localization string generator
  - File generator
- How to use the script, and what does it work for?
  - start your terminal -> checkout to this project's folder path -> run `sh release.sh`
  - the script will do the following things:
    - compile the project to make a Command Line Tool
    - move the Command Line Tool to the folder `./Released`
  - after that, you can cd to `./Released`, and try your Command Line Tool.

   
