import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('User Statistics')

st.write('### Total Users')

users = requests.get('http://api:4000/a/users').json()

try:
    st.dataframe(users)
except:
    st.write("**Important**: Could not connect to database to get users!")


st.write('### Total Active Users')
activeUsers = requests.get('http://api:4000/a/activeUsers').json()
try:
    st.dataframe(activeUsers)
except:
    st.write("**Important**: Could not connect to database to get active users!")
