package downloader

import (
	"net/http"
)

// HTTPClient is client for creating and submiting http requests
type HTTPClient struct {
	client  *http.Client
	request *http.Request
}

func (httpClient *HTTPClient) InitClient() {
	httpClient.client = &http.Client{}
	return
}

func (httpClient *HTTPClient) CreateGetRequest(url string) {
	httpClient.request, _ = http.NewRequest("GET", url, nil)
	httpClient.request.Header.Add("Content-Type", "application/json")
	return
}

func (httpClient *HTTPClient) ExecuteRequest() (*http.Response, error) {
	if httpClient.client == nil {
		return nil, &ErrorHTTPClient{"Error: httpClient not initialized"}
	}
	if httpClient.request == nil {
		return nil, &ErrorHTTPClient{"Error: httpClient does not have request"}
	}
	return httpClient.client.Do(httpClient.request)
}

// ErrorHTTPClient is structure for handling donwloader errors
type ErrorHTTPClient struct {
	errorText string
}

func (err *ErrorHTTPClient) Error() string {
	return err.errorText
}
