package main

import (
	"bufio"
	"fmt"
	"go-cli/downloader"
	"go-cli/parser"
	"io/ioutil"
	"net/http"
	"os"
	"sync"
	"time"
)

// Example of asynchronous download
// Press enter when promted to, download will start
// After download finishses, start new download bz presing enter
func main() {
	displayString := displayString{"Press enter to start download", false, sync.Mutex{}}
	loading := loading()
	for {
		displayString.Write(loading)
		// Reasonable refresh rate
		time.Sleep(200 * time.Millisecond)
	}
}

type displayString struct {
	text            string
	ongoingDownload bool
	mutex           sync.Mutex
}

func (displayString *displayString) Write(loading func(displayString *displayString)) {
	displayString.mutex.Lock()
	fmt.Println(displayString.text)
	if displayString.ongoingDownload == false {
		bufio.NewReader(os.Stdin).ReadBytes('\n')
		displayString.ongoingDownload = true
		go download(displayString)
	}
	go loading(displayString)
	displayString.mutex.Unlock()
}

func download(displayString *displayString) {
	client := downloader.HTTPClient{}
	client.InitClient()
	client.CreateGetRequest("https://private-9d572-asynchronoustasks.apiary-mock.com/basic")
	changeDisplyString(displayString, handleResponse(client.ExecuteRequest()), false)
}

func handleResponse(response *http.Response, err error) string {
	if err != nil {
		return err.Error()
	}
	defer response.Body.Close()

	if response.Status != "200 OK" {
		return "Error: " + response.Status
	}
	responseText, _ := ioutil.ReadAll(response.Body)
	return parser.LanguagesJSONParse(string(responseText))
}

func loading() func(displayString *displayString) {
	counter := 2
	function := func(displayString *displayString) {
		counter = (counter + 1) % 3
		text := "Loading."
		for i := 0; i < counter; i++ {
			text += "."
		}
		changeDisplyString(displayString, text, true)
	}
	return function
}

func changeDisplyString(displayString *displayString, newText string, newOngoingDownload bool) {
	displayString.mutex.Lock()
	if displayString.ongoingDownload == true {
		displayString.text = newText
		displayString.ongoingDownload = newOngoingDownload
	}
	displayString.mutex.Unlock()
}
