using Newtonsoft.Json;

namespace async
{
    public class Parser
    {
        public SupportedLanguages Parse(string json)
        {
            return JsonConvert.DeserializeObject<SupportedLanguages>(json);
        }
    }
}
