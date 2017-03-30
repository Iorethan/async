using System.Collections.Generic;
using Newtonsoft.Json;

namespace async
{
    public class SupportedLanguages
    {
        [JsonProperty(PropertyName = "supported")]
        public List<string> Languages { get; set; }
    }
}
