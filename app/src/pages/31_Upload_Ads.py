import logging

logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests


st.set_page_config(layout="wide")

SideBarLinks()


advertiser_id = st.text_input("Advertiser ID")
ad_content = st.text_area("Ad Content")
ad_id = st.text_input("Advertisement ID")


if st.button("Create Advertisement"):
    data = {
        "advertiser_id": advertiser_id,
        "content": ad_content,
        "advertisement_id": ad_id,
    }

    try:
        response = requests.post("http://api:4000/ad/advertisement", json=data)
    except:
        st.write(f"Failed to create advertisement")

    if response.status_code == 200:
        st.write("Advertisement created!")
