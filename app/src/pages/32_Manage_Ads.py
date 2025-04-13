import logging

logger = logging.getLogger(__name__)

import streamlit as st

from modules.nav import SideBarLinks
import requests

SideBarLinks()

st.write("Available ad spaces")
avail = requests.get("http://api:4000/ad/ad_spaces")

st.dataframe(avail, hide_index=True)

st.divider()

choice = st.radio("Modify ad space", ["Upload ads", "Remove ads"])

st.divider()

if choice == "Upload ads":
    ad_space_id = st.number_input("Ad space to upload to:", value=0, step=1)
    ad_id = st.number_input("Advertisement id to upload:", value=0, step=1)
    data = {
        "ad_space_id": ad_space_id,
        "advertisement_id": ad_id,
    }
    try:
        response = requests.put(
            "http://api:4000/ad/ad_space/advertisement/{ad_space_id}/{ad_id}", json=data
        )
    except:
        st.write(f"Failed to upload advertisement to ad space")

    if response.status_code == 200:
        st.write("Advertisement uploaded!")

if choice == "Remove ads":
    ad_space_id = st.number_input("Ad space to remove from:", value=0, step=1)
    data = {
        "ad_space_id": ad_space_id,
    }
    try:
        response = requests.put(
            "http://api:4000/ad/ad_space/advertisement/{ad_space_id}", json=data
        )
    except:
        st.write(f"Failed to remove advertisement from ad space")

    if response.status_code == 200:
        st.write("Advertisement removed!")
