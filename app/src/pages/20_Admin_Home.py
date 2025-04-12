import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('System Admin Home Page')
st.write('### Welcome to the System Admin Home Page!')

st.divider()
st.write('#### User Management')
if st.button('View user statistics', 
             type='primary',
             use_container_width=True):
    st.switch_page('pages/22_User_Stats.py')

st.divider()
st.write('#### Restaurant Management')
if st.button('View restaurants requiring approval', 
             type='primary',
             use_container_width=True):
    st.switch_page('pages/23_Restaurant_Approval.py')

st.divider()
st.write('#### Advertisement Management')
if st.button('Manage ads and view ad revenue', 
             type='primary',
             use_container_width=True):
    st.switch_page('pages/24_Ad_Revenue.py')