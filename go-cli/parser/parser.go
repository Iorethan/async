package parser

import (
	"encoding/json"
	"strings"
)

// LanguagesJSONParse parses list of languges in json
func LanguagesJSONParse(jsonString string) string {
	decoder := json.NewDecoder(strings.NewReader(jsonString))
	var languages supportedLanguages
	if err := decoder.Decode(&languages); err != nil {
		return "Error: cannot parse json"
	}
	return languagesToString(languages)
}

func languagesToString(languages supportedLanguages) string {
	parsedString := ""
	for i := 0; i < len(languages.Supported); i++ {
		parsedString += languages.Supported[i]
		if i+1 < len(languages.Supported) {
			parsedString += ", "
		}
	}
	return parsedString
}

type supportedLanguages struct {
	Supported []string `json:"supported"`
}
