<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Leonardo's Drive</title>
    <link rel="stylesheet" href="/Caddyr/style.css" />
    <script src="/Caddyr/app.js" type="text/javascript" charset="utf-8"></script>
    
    <style>
        /* 125% ZOOM */
        html {
            font-size: 125% !important; 
        }

        @media (prefers-color-scheme: dark) {
            /* 1. NUKE WHITE STRIPE & DEFAULT BROWSER MARGINS */
            html, body, header {
                background-color: #1e1e1e !important;
                background-image: none !important;
                color: #ffffff !important; 
                margin: 0 !important; 
                padding: 0 !important; 
                border: none !important;
                box-shadow: none !important;
            }

            html::before, html::after, body::before, body::after {
                display: none !important; 
                content: none !important;
            }
            
            body { min-height: 100vh; }

            /* 2. PROPER CENTERING FOR TITLE AND FILES */
            h1 {
                background-color: transparent !important;
                color: #ffffff !important;
                max-width: 1000px !important; 
                width: 90% !important;
                margin: 0 auto !important; 
                padding: 30px 0 10px 0 !important;
                border: none !important;
            }

            .wrapper {
                background-color: transparent !important;
                max-width: 1000px !important;
                width: 90% !important;
                margin: 0 auto !important; 
                box-sizing: border-box !important;
                padding: 0 0 40px 0 !important;
                box-shadow: none !important;
                border: none !important;
            }

            /* 3. FIX SEARCH BAR DESIGN AND ICON PLACEMENT */
            input[type="search"] {
                background-color: #2a2a2a !important;
                color: #ffffff !important;
                border: 1px solid #555 !important;
                border-radius: 8px !important; 
                padding: 8px 35px 8px 16px !important; 
                background-position: right 10px center !important; 
                outline: none !important;
                margin-bottom: 10px !important;
                font-size: 0.9em !important;
            }
            
            input[type="search"]:focus {
                border-color: #888 !important; 
            }

            input[type="search"]::-webkit-search-cancel-button,
            input[type="search"]::-webkit-search-decoration {
                margin-right: 5px;
            }

            /* 4. TABLE STYLING */
            table {
                width: 100% !important;
                border-collapse: collapse !important;
            }

            table th {
                background-color: #1e1e1e !important;
                border-bottom: 1px solid rgba(255, 255, 255, 0.2) !important;
                padding-bottom: 10px !important;
                text-align: left !important;
            }

            table tr, table th, table td {
                border-top: none !important;
                border-left: none !important;
                border-right: none !important;
            }
            
            table tbody td {
                border-bottom: 1px solid rgba(255, 255, 255, 0.08) !important;
                padding: 12px 8px !important; 
            }
            
            table tbody tr td {
                transition: background-color 0.2s ease !important;
                background-color: transparent !important;
            }

            table tbody tr:hover, 
            table tbody tr:hover td,
            table tbody td:hover {
                background-color: #2a2a2a !important; 
                cursor: pointer;
            }
            
            a, a:visited, a:hover, a:active {
                color: #ffffff !important;
                text-decoration: none !important;
            }
            
            svg { fill: #ffffff !important; }

            /* 5. ULTRA-MINIMAL README BLOCK */
            #readme-container {
                display: none; 
                margin-top: 60px;
                padding: 0 8px; /* Aligns text with the table cell padding above */
            }

            .readme-title {
                font-size: 0.85em;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: #888;
                margin-top: 0;
                margin-bottom: 15px;
            }

            #readme-content {
                white-space: pre-wrap; 
                word-wrap: break-word;
                font-family: monospace;
                font-size: 0.9em;
                color: #dcdcdc;
                line-height: 1.6;
                margin: 0;
            }
        }
    </style>
  </head>
  <body>
    <h1>Leonardo's Drive {{.Path}}</h1>
    <div class="wrapper">
      <form>
        <input id="searchTerm" name="filter" type="search" autocapitalize="none" onkeyup="doSearch()">
      </form>
      
      <script>let hasReadme = false;</script>

      <table>
        <thead>
          <tr>
            <th><img src="/Caddyr/icons/default.png" alt="[ICO]"></th>
            <th><a id="link-name">Name</a></th>
            <th><a id="link-time">Modified</a></th>
            <th><a id="link-size">Size</a></th>
          </tr>
        </thead>
        <tbody id="dataTable">
          {{if .CanGoUp}}
          <tr>
            <td valign="top">
              <a href=".."><img src="/Caddyr/icons/up.png" alt="[ICO]"></a>
            </td>
            <td><a href="..">Go up a dir</a></td>
            <td></td>
            <td align="right">&mdash;</td>
          </tr>
          {{end}}

          {{range .Items}}
            {{if eq .Name "README.txt"}}
              <script>hasReadme = true;</script>
            {{else if ne .Name "Caddyr" }}
              {{if not .IsDir}}
              <a class="play" href="intent:{{.URL}}#Intent;scheme=file;action=android.intent.action.VIEW;end;"target="_blank">
              {{end}}
              <tr>
                <td valign="top">
                  <a href="{{.URL}}">
                    {{if .IsDir}}
                    <img src="/Caddyr/icons/dir.png" alt="[IMG]"></a>
                  {{else}}
                  <script>
                    document.write('<img src="/Caddyr/icons/'+extension("{{.Name}}")+'.png" alt="[IMG]" onerror="this.src=\'/Caddyr/icons/default.png\'"/>');
                  </script>
                  {{end}}
                </td>
                <td><a href="{{.URL}}">{{.Name}}</a></td>
                <td><script>document.write(prettyDate("{{.ModTime}}"));</script></td>
                <td align="right">
                  {{if not .IsDir}}
                  <script>document.write(humanFileSize({{.Size}}));</script>
                  {{else}}
                  Directory
                  {{end}}
                </td>
              </tr>
              {{if not .IsDir}}
              </a>
              {{end}}
            {{end}}
          {{end}}
        </tbody>
      </table>

      <!-- Minimal README Container -->
      <div id="readme-container">
        <h2 class="readme-title">README.txt</h2>
        <pre id="readme-content">Loading...</pre>
      </div>

    </div>

    <script>
      if (hasReadme) {
        fetch('README.txt')
          .then(response => {
             if (response.ok) return response.text();
             throw new Error('README could not be loaded.');
          })
          .then(text => {
            document.getElementById('readme-content').textContent = text;
            document.getElementById('readme-container').style.display = 'block';
          })
          .catch(error => console.error('Error fetching README:', error));
      }
    </script>
  </body>
</html>