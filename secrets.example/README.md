# Secrets 設定

## Demo 模式（推薦測試用）

如果不需要 Google Calendar 整合功能，可以使用空的 service account 檔案：

1. 建立 `secrets` 目錄：
   ```bash
   mkdir secrets
   ```

2. 建立一個空的或假的 `google-service-account.json`：
   ```bash
   cp secrets.example/google-service-account.json.example secrets/google-service-account.json
   ```

3. 在 `.env` 中設定 `ENABLE_GOOGLE_SYNC=false`（`.env.demo` 已預設關閉）

## 正式環境

如需啟用 Google Calendar 同步功能：

1. 在 Google Cloud Console 建立服務帳戶
2. 下載 JSON 金鑰檔案
3. 將檔案放置於 `secrets/google-service-account.json`
4. 設定 `ENABLE_GOOGLE_SYNC=true`
