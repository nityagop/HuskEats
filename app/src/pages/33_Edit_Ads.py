import logging

logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests
import pandas as pd

st.set_page_config(layout="wide")

SideBarLinks()
advertiser_id = 2
st.write("#### Your Current Ads")

advertisements = requests.get(
    f"http://api:4000/ad/ad_space/advertisement/{advertiser_id}"
).json()


st.dataframe(pd.DataFrame(advertisements), hide_index=True)

st.divider()


ad_id = st.text_input("Advertisement ID to edit:")
ad_content = st.text_area("Write new content:")


if st.button("Update Advertisement"):
    response = requests.put(f"http://api:4000/ad/advertisement/{ad_id}/{ad_content}")

    st.session_state.advertisement_edit_df = pd.DataFrame(
        requests.get(
            f"http://api:4000/ad/ad_space/advertisement/{advertiser_id}"
        ).json()
    )
    st.rerun()


st.divider()

ad_del_id = st.text_input("Advertisement ID to DELETE:")
if st.button("Delete advertisement"):
    response = requests.delete(f"http://api:4000/ad/advertisement/{ad_del_id}")
    st.session_state.advertisement_edit_df = pd.DataFrame(
        requests.get(
            f"http://api:4000/ad/ad_space/advertisement/{advertiser_id}"
        ).json()
    )
    st.rerun()
