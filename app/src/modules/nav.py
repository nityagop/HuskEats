# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has function to add certain functionality to the left side bar of the app

import streamlit as st


#### ------------------------ General ------------------------
def HomeNav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")


#### ------------------------ Examples for Role of pol_strat_advisor ------------------------
def PolStratAdvHomeNav():
    st.sidebar.page_link(
        "pages/RestaurantOwnerHome.py", label="Political Strategist Home", icon="👤"
    )


def WorldBankVizNav():
    st.sidebar.page_link(
        "pages/Ratings.py", label="World Bank Visualization", icon="🏦"
    )


def MapDemoNav():
    st.sidebar.page_link("pages/02_Map_Demo.py", label="Map Demonstration", icon="🗺️")


## ------------------------ Examples for Role of usaid_worker ------------------------
def ApiTestNav():
    st.sidebar.page_link("pages/12_API_Test.py", label="Test the API", icon="🛜")


def PredictionNav():
    st.sidebar.page_link(
        "pages/11_Prediction_Calc.py", label="Regression Prediction", icon="📈"
    )


def ClassificationNav():
    st.sidebar.page_link(
        "pages/13_Classification.py", label="Classification Demo", icon="🌺"
    )


#### ------------------------ System Admin Role ------------------------
def AdminPageNav():
    st.sidebar.page_link("pages/20_Admin_Home.py", label="System Admin", icon="🖥️")


def UserStatsNav():
    st.sidebar.page_link("pages/22_User_Stats.py", label="User Statistics", icon="📊")


def RestaurantApprovalNav():
    st.sidebar.page_link(
        "pages/23_Restaurant_Approval.py", label="Restaurant Approval", icon="🍔"
    )


def AdRevenueNav():
    st.sidebar.page_link("pages/24_Ad_Revenue.py", label="Ad Revenue", icon="💰")


#### -------------------- Advertiser Role ------------------


def AdvertiserPageNav():
    st.sidebar.page_link(
        "pages/30_Advertiser_Home.py", label="Advertiser Home", icon="💲"
    )


def UploadAdPageNav():
    st.sidebar.page_link("pages/31_Upload_Ads.py", label="Upload Ads", icon="🔼")


def ManageAdPageNav():
    st.sidebar.page_link("pages/32_Manage_Ads.py", label="Manage Ads", icon="➕")


def EditAdPageNav():
    st.sidebar.page_link("pages/33_Edit_Ads.py", label="Edit Ads", icon="✏️")


# --------------------------------Links Function -----------------------------------------------
def SideBarLinks(show_home=False):
    """
    This function handles adding links to the sidebar of the app based upon the logged-in user's role, which was put in the streamlit session_state object when logging in.
    """

    # add a logo to the sidebar always
    st.sidebar.image("assets/logo.png", width=150)

    # If there is no logged in user, redirect to the Home (Landing) page
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page("Home.py")

    if show_home:
        # Show the Home page link (the landing page)
        HomeNav()

    # Show the other page navigators depending on the users' role.
    if st.session_state["authenticated"]:

        # Show World Bank Link and Map Demo Link if the user is a political strategy advisor role.
        if st.session_state["role"] == "pol_strat_advisor":
            PolStratAdvHomeNav()
            WorldBankVizNav()
            MapDemoNav()

        # If the user role is advertiser, show advertiser pages
        if st.session_state["role"] == "advertiser":
            AdvertiserPageNav()
            UploadAdPageNav()
            ManageAdPageNav()
            EditAdPageNav()

        # If the user is an administrator, give them access to the administrator pages
        if st.session_state["role"] == "administrator":
            AdminPageNav()
            UserStatsNav()
            RestaurantApprovalNav()
            AdRevenueNav()

    if st.session_state["authenticated"]:
        # Always show a logout button if there is a logged in user
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")
