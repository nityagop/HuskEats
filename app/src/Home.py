##################################################
# This is the main/entry-point file for the
# sample application for your project
##################################################

# Set up basic logging infrastructure
import logging

logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

# import the main streamlit library as well
# as SideBarLinks function from src/modules folder
import streamlit as st
from modules.nav import SideBarLinks

# streamlit supports reguarl and wide layout (how the controls
# are organized/displayed on the screen).
st.set_page_config(layout="wide")

# If a user is at this page, we assume they are not
# authenticated.  So we change the 'authenticated' value
# in the streamlit session_state to false.
st.session_state["authenticated"] = False

# Use the SideBarLinks function from src/modules/nav.py to control
# the links displayed on the left-side panel.
# IMPORTANT: ensure src/.streamlit/config.toml sets
# showSidebarNavigation = false in the [client] section
SideBarLinks(show_home=True)

# ***************************************************
#    The major content of this page
# ***************************************************

# set the title of the page and provide a simple prompt.
logger.info("Loading the Home page of the app")
st.title("HuskEats Home Page")
st.write("\n\n")
st.info("### HI! As which user would you like to log in?")

# For each of the user personas for which we are implementing
# functionality, we put a button on the screen that the user
# can click to MIMIC logging in as that mock user.
st.divider()
if st.button(
    "Act as Jake, a Restaurant Owner", type="primary", use_container_width=True
):
    # when user clicks the button, they are now considered authenticated
    st.session_state["authenticated"] = True
    # we set the role of the current user
    st.session_state["role"] = "resteraunt_owner"
    # we add the first name of the user (so it can be displayed on
    # subsequent pages).
    st.session_state["first_name"] = "Jake"
    # finally, we ask streamlit to switch to another page, in this case, the
    st.session_state["role"] = "restaurant_owner"
    # we add the first name of the user (so it can be displayed on
    # subsequent pages).
    st.session_state["first_name"] = "Jake"
    # finally, we ask streamlit to switch to another page, in this case, the
    # landing page for this particular user type
    logger.info("Logging in as Restaurant Owner")
    st.switch_page("pages/40_RestaurantOwnerHome.py")
st.divider()
if st.button(
    "Act as Bob, a Northeastern Student", type="primary", use_container_width=True
):
    st.session_state["authenticated"] = True
    st.session_state["role"] = "student"
    st.session_state["first_name"] = "Bob"
    logger.info("Logging in as Student")
    st.switch_page("pages/10_Student_Home.py")
st.divider()
if st.button(
    "Act as Lindsay, System Administrator", type="primary", use_container_width=True
):
    st.session_state["authenticated"] = True
    st.session_state["role"] = "administrator"
    st.session_state["first_name"] = "Lindsay"
    logger.info("Logging in as System Administrator")
    st.switch_page("pages/20_Admin_Home.py")

st.divider()
if st.button("Act as Patrick, an Advertiser", type="primary", use_container_width=True):
    st.session_state["authenticated"] = True
    st.session_state["role"] = "advertiser"
    st.session_state["first_name"] = "Patrick"
    st.switch_page("pages/30_Advertiser_Home.py")
