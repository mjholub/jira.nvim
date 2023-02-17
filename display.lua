local function get_jira_issue(jira_base_url, issue_key, api_token)
  local http = require('socket.http')
  local response = {}

  local url = string.format('%s/rest/api/2/issue/%s', jira_base_url, issue_key)
  local headers = {
    ['Authorization'] = string.format('Basic %s', api_token)
  }

  local success, status_code, response_headers, status_text = http.request{
    url = url,
    headers = headers,
    sink = ltn12.sink.table(response)
  }

  if success and status_code == 200 then
    return vim.fn.json_decode(table.concat(response))
  else
    return nil
  end
end

