# DreamAuto Sample Application

DreamAuto is a sample application that demonstrates the Igor Shlepanov's skills of creating apps on the Salesforce platform. 

This application incorporates LWC and other features to deliver a user experience that helps DreamAuto, a fictitious luxury car renting company, manage its cars and car suppliers using the Salesforce Platform.


## Table of contents

-   [What Features Can You Find in this App?](#what_features_can_you_find_in_this_app): The list of Salesforce features that were used in this app.

-   [Installing DreamAuto Using a Scratch Org](#installing-dreamauto-using-a-scratch-org): This is the recommended installation option. Use this option if you are a developer who wants to experience the app and the code.

-   [Installing DreamAuto Using an Unlocked Package](#installing-dreamauto-using-an-unlocked-package): This option allows anybody to experience the sample app without installing a local development environment.

-   [Installing DreamAuto using a Developer Edition Org or a Trailhead Playground](#installing-dreamauto-using-a-developer-edition-org-or-a-trailhead-playground): Useful if you want the app deployed to a permanent environment.

-   [About Author](#about-author): My contacts.


## What Features Can You Find in this App?

- custom objects (car, car type, car review)
- master-detail and lookup relationship
- apps, tabs
- Apex classes, test classes, TestDataFactory
- serializing into JSON and deserializing
- lightning pages
- LWC
- message channels
- static resources
- Package deployment


## Installing DreamAuto using a Scratch Org

1. Set up your environment. Follow the steps in the [Quick Start: Lightning Web Components](https://trailhead.salesforce.com/content/learn/projects/quick-start-lightning-web-components/) Trailhead project. The steps include:

    - Enable Dev Hub in your Trailhead Playground
    - Install Salesforce CLI
    - Install Visual Studio Code
    - Install the Visual Studio Code Salesforce extensions, including the Lightning Web Components extension

1. If you haven't already done so, authorize your hub org and provide it with an alias (**myhuborg** in the command below):

    ```
    sf org login web -d -a myhuborg
    ```

1. Clone this repository:

    ```
    git clone https://github.com/IgorSCode-py/DreamAuto
    cd dreamauto
    ```

1. Create a scratch org and provide it with an alias (**dreamauto** in the command below):

    ```
    sf org create scratch -d -f config/project-scratch-def.json -a dreamauto
    ```

1. Push the app to your scratch org:

    ```
    sf project deploy start
    ```

1. Assign the **Dream Auto users** permission set to the default user:

    ```
    sf org assign permset -n Dream_Auto_users
    ```

1. Import sample data:

    ```
    sf data tree import -p data/sample-data-plan.json
    ```

1. Open the scratch org:

    ```
    sf org open
    ```

1. In **Setup**, under **Themes and Branding**, activate the **Lightning Lite** theme.

1. In App Launcher, select the **DreamAuto** app.


## Installing DreamAuto using an Unlocked Package

Follow this set of instructions if you want to deploy the app to a more permanent environment than a Scratch org or if you don't want to install the local developement tools. You can use a non source-tracked orgs such as a free [Developer Edition Org](https://developer.salesforce.com/signup) or a [Trailhead Playground](https://trailhead.salesforce.com/).

Make sure to start from a brand-new environment to avoid conflicts with previous work you may have done.

1. Log in to your org

1. Click [this link](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t7Q0000009vyeQAA) to install the DreamAuto unlocked package in your org.

1. Select **Install for All Users**

1. In App Launcher, click **View all**, select the DreamAuto app.

1. Click the **Settings** tab and click the **Import Data** button in the **Sample Data Import** component.

1. If you're unable to open DreamAuto app, do this steps, but otherwise, skip:

    - Go to **Setup > Users > Permission Sets**.
    - Click **Dream Auto users**.
    - Click **Manage Assignments**.
    - Check your user and click **Add Assignments**.

1. In **Setup**, under **Themes and Branding**, activate the **Lightning Lite** theme.

1. In App Launcher, select the **DreamAuto** app.


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

1. Assign the `Dream Auto users` permission set to the default user.

    ```
    sf org assign permset -n Dream_Auto_users
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
