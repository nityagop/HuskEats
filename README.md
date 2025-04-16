# HuskEats: CS3200 Final Project

### Overview 

Group Members: Nitya Gopalakrishnan, Hailee Fonseca, Gloria Ge, Simar Sidhu, and Aura Herce
<br> 
Link to Demo Video: 

## What is HuskEats?

   HuskEats is an application specifically built for Northeastern students to dicuss, share, and rate resteraunts around the Northeastern area, as well as mark their favorite restaurants. 
   This application will be named HuskEats, and will allow users to not only review restaurants, but also provide a forum space for users to talk about resteraunts, review them, and answer reviews as well.
   This application will also allow resteraunt owners to view and reply to reviews on their resteraunts, update all of their restaurant's information such as hours, address, menu hours, etc, and check their restaurant's rating.
   This application will also allow advertisers to Upload, Manage, and Edit their advertisements on the application to allow the application to make money and for advertisers to have control in how they are publishing their product.
   This application will have administrator users as well, who can check User Statistics, Approve Resteraunts to be listed on the main application page for all users to find, and check Ad Revenue for advertisers who will request data.
   This application will also have a home page specific to every user to allow users to navigate between different tasks that they wish to accomplish.
   
## Prerequisites

- A GitHub Account
- A terminal-based git client or GUI Git client such as GitHub Desktop or the Git plugin for VSCode.
- VSCode with the Python Plugin
- A distribution of Python running on your laptop. The distro supported by the course is Anaconda or Miniconda.

## Project Components and Requirements 

Currently, there are three major components that will each run in their own Docker Containers:

- Streamlit App in the `./app` directory
- Flask REST api in the `./api` directory
- MySQL Database that will be initialized with SQL script files from the `./database-files` directory

There are also several requirements necessary to run the project:
- Werkzeug Version 2.3.8
- Flask Version 2.3.3
- Flask-restful Version 0.3.9
- Flask-login Version 0.6.2
- Flask-mysql Version 1.5.2
- Cryptography Version 38.0.1
- Python-dotenv Version 1.0.1
- Numpy Version 1.26.4

## To Run HuskEats Web Application

1. Clone the HuskEats repository from GitHub
2. Ensure you have Docker Desktop, Git, and Python installed
3. Configure the `.env` file to match this:

   <img width="275" alt="image" src="https://github.com/user-attachments/assets/ef9fdcbd-deaa-4094-b670-32553590431b" />
4. Use `docker compose build` to build the Docker containers
5. Use `docker compose up -d` to start the Docker containers
6. Access HuskEats web application on http://localhost:8501/
   
