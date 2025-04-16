import logging

logger = logging.getLogger(__name__)

import streamlit as st

from modules.nav import SideBarLinks
import requests
import pandas as pd

SideBarLinks()

st.write("#### Unpurchased Ad Spaces")
avail = requests.get("http://api:4000/ad/ad_spaces").json()

if "avail_adspace" not in st.session_state:
    st.session_state.avail_adspace = pd.DataFrame(avail)

st.dataframe(st.session_state.avail_adspace, hide_index=True)

st.write("#### Your Current Ads")

advertiser_id = 2
advertisements = requests.get(
    f"http://api:4000/ad/ad_space/advertisement/{advertiser_id}"
).json()
if "advertisement_edit_df" not in st.session_state:
    st.session_state.advertisement_edit_df = pd.DataFrame(advertisements)

st.dataframe(st.session_state.advertisement_edit_df, hide_index=True)


st.divider()


choice = st.radio("Modify occupied ad space", ["Upload an ad", "Remove an ad"])

st.divider()

if choice == "Upload an ad":
    ad_space_id = int(st.number_input("Ad space to upload to:", value=0, step=1))
    ad_id = int(st.number_input("Advertisement id to upload:", value=0, step=1))

    if st.button("Update Advertisement"):
        response = requests.put(
            f"http://api:4000/ad/ad_space/advertisement/{ad_space_id}/{ad_id}"
        )
        st.session_state.avail_adspace = requests.get(
            "http://api:4000/ad/ad_spaces"
        ).json()
        st.session_state.advertisement_edit_df = requests.get(
            f"http://api:4000/ad/ad_space/advertisement/{advertiser_id}"
        ).json()

if choice == "Remove an ad":
    ad_space_id = int(st.number_input("Ad space to remove from:", value=0, step=1))
    if st.button("Update Advertisement"):
        response = requests.put(
            f"http://api:4000/ad/ad_space/advertisement/{ad_space_id}"
        )
        st.session_state.avail_adspace = requests.get(
            "http://api:4000/ad/ad_spaces"
        ).json()

        st.session_state.advertisement_edit_df = requests.get(
            f"http://api:4000/ad/ad_space/advertisement/{advertiser_id}"
        ).json()
