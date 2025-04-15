import logging

logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout="wide")

SideBarLinks()

st.title("Advertiser Home Page")
st.write("### View and manage ads here!")
st.write("Logged in as advertiser id: 2")

st.divider()
st.write("#### Upload")
if st.button("Upload advertisements", type="primary", use_container_width=True):
    st.switch_page("pages/31_Upload_Ads.py")

st.divider()
st.write("#### Manage")
if st.button("Manage Ad Space", type="primary", use_container_width=True):
    st.switch_page("pages/32_Manage_Ads.py")

if st.button("Edit Advertisement Content", type="primary", use_container_width=True):
    st.switch_page("pages/33_Edit_Ads.py")
