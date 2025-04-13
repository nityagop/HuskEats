import logging
logger = logging.getLogger(__name__)
import streamlit as st
from streamlit_extras.app_logo import add_logo
import pandas as pd
import pydeck as pdk
from urllib.error import URLError
from modules.nav import SideBarLinks
import requests 

SideBarLinks()

# add the logo
add_logo("assets/logo.png", height=400)

# set up the page

st.header('My Reviews')

reply_response = requests.get('http://api:4000/r/restaurant_owners').json()


