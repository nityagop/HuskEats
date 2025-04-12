import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('Review Restaurants Requiring Approval')
st.write('### Restaurants Requiring Approval')

restaurants = requests.get('http://api:4000/a/restaurants').json()

try:
    st.dataframe(restaurants)
except:
    st.write("**Important**: Could not connect to database to get restaurants!")

