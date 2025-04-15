import logging

logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests


st.set_page_config(layout="wide")

SideBarLinks()


ad_content = st.text_area("Ad Content")
advertiser_id = 2


if st.button("Create Advertisement"):
    data = {
        "advertiser_id": advertiser_id,
        "content": ad_content,
    }

    response = requests.post("http://api:4000/ad/advertisement", json=data)
