import logging

logger = logging.getLogger(__name__)

import streamlit as st

from modules.nav import SideBarLinks
import requests
import pandas as pd

SideBarLinks()

st.write("Ad space data")
avail = requests.get("http://api:4000/ad/ad_spaces").json()

st.dataframe(avail, hide_index=True)

st.write("Your current ads")

advertiser_id = 2
advertisements = requests.get(
    f"http://api:4000/ad/ad_space/advertisement/{advertiser_id}"
).json()
if "advertisement_edit_df" not in st.session_state:
    st.session_state.advertisement_edit_df = pd.DataFrame(advertisements)

st.dataframe(st.session_state.advertisement_edit_df, hide_index=True)


st.divider()

choice = st.radio("Modify ad space", ["Upload ads", "Remove ads"])

st.divider()

if choice == "Upload ads":
    ad_space_id = int(st.number_input("Ad space to upload to:", value=0, step=1))
    ad_id = int(st.number_input("Advertisement id to upload:", value=0, step=1))

    if st.button("Update Advertisement"):
        response = requests.put(
            f"http://api:4000/ad/ad_space/advertisement/{ad_space_id}/{ad_id}"
        )

if choice == "Remove ads":
    ad_space_id = int(st.number_input("Ad space to remove from:", value=0, step=1))
    if st.button("Update Advertisement"):
        response = requests.put(
            f"http://api:4000/ad/ad_space/advertisement/{ad_space_id}"
        )
