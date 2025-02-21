import speedtest

def test_internet_speed():
    st = speedtest.Speedtest()
    st.download()
    st.upload()
    st.results.share()

    results = st.results.dict()
    print(f"Download speed: {results['download'] / 1_000_000:.2f} Mbps")
    print(f"Upload speed: {results['upload'] / 1_000_000:.2f} Mbps")
    print(f"Ping: {results['ping']} ms")
    print(f"Server: {results['server']['name']}, {results['server']['country']}")

if __name__ == "__main__":
    test_internet_speed()