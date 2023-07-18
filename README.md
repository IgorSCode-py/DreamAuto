# DreamAuto Sample Application

DreamAuto is a sample application that demonstrates the Igor Shlepanov's skills of creating apps on the Salesforce platform. 

This application incorporates LWC and other features to deliver a user experience that helps DreamAuto, a fictitious luxury car renting company, manage its cars and car suppliers using the Salesforce Platform.


## What Features Can You Find in this App?

-   LWC

-   Message Channels


## Table of contents

-   [Installing DreamAuto using a Developer Edition Org or a Trailhead Playground](#installing-dreamauto-using-a-developer-edition-org-or-a-trailhead-playground): Useful when tackling Trailhead Badges or if you want the app deployed to a permanent environment.

-   [About Author](#about-author): My contacts.


## Installing DreamAuto using a Developer Edition Org or a Trailhead Playground

Follow this set of instructions if you want to deploy the app to a more permanent environment than a Scratch org.
This includes non source-tracked orgs such as a [free Developer Edition Org](https://developer.salesforce.com/signup) or a [Trailhead Playground](https://trailhead.salesforce.com/).

Make sure to start from a brand-new environment to avoid conflicts with previous work you may have done.

1. Clone this repository:

    ```
    git clone https://github.com/IgorSCode-py/DreamAuto
    cd dreamauto
    ```

1. Authorize your Trailhead Playground or Developer org and provide it with an alias (**mydevorg** in the command below):

    ```
    sf org login web -s -a mydevorg
    ```

1. Run this command in a terminal to deploy the app.

    ```
    sf project deploy start -d force-app
    ```

1. Assign the `dreamautousers` permission set to the default user.

    ```
    sf org assign permset -n dreamautousers
    ```

1. Import some sample data.

    ```
    sf data tree import -p ./data/sample-data-plan.json
    ```

1. If your org isn't already open, open it now:

    ```
    sf org open -o mydevorg
    ```

1. In **Setup**, under **Themes and Branding**, activate the **Lightning Lite** theme.

1. In App Launcher, select the **DreamAuto** app.

## About Author

This is a part of Igor Shlepanov's portfolio.

You can find me here:

- [LinkedIn](https://www.linkedin.com/in/igor-shlepanov-b22a8863/)
- [Trailblaizer](https://trailblazer.me/id/ishlepanov)
