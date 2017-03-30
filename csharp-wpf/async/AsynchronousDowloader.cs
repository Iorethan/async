using System;
using System.Collections;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace async
{
    public class AsynchronousDowloader
    {
        public async Task<string> Get(string url)
        {
            var baseAddress = new Uri(url);
            using (var httpClient = new HttpClient { BaseAddress = baseAddress })
            {
                using (var response = await httpClient.GetAsync(url))
                {
                    return await response.Content.ReadAsStringAsync();
                }
            }
        }

        public async Task<string> Post(string url)
        {
            var baseAddress = new Uri(url);
            using (var httpClient = new HttpClient { BaseAddress = baseAddress })
            {
                using (var content = new StringContent("{  \"_session\": \"demo\",  \"credentials\": {    \"username\": \"demo\",    \"password\": \"demo\"  }}", System.Text.Encoding.Default, "application/json"))
                {
                    using (var response = await httpClient.PostAsync(url, content))
                    {
                        return await response.Content.ReadAsStringAsync();
                    }
                }
            }
        }
    }
}
