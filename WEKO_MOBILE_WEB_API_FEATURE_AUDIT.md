# WEKO.PRO Mobile & Web API Feature Audit Report

This report compares the functionality, API usage, and UX flows of the **WEKO.PRO Web Platform** and the **Flutter Mobile App**. It highlights discrepancies, identifies missing features and bugs, outlines backend changes required for native In-App Purchases, and concludes with a prioritized action list.

---

## 1. Feature & API Audit Table

| Module | Web Feature | Mobile Status | API Status | Missing/Issue | Required Action |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Auth** | Password Login | Complete | Matching | None | None |
| **Auth** | Google Sign-In | Complete | Matching | None | None |
| **Auth** | Registration / OTP | Complete | Matching | None | None |
| **Dashboard** | Client Stats | Complete | Matching | Loaded via client stats API | None |
| **Dashboard** | Trader Stats | Incomplete | Incomplete | Trader stats load client endpoint on home cubit initialization | Update home repository to dynamically route to trader dashboard statistics endpoint based on user role |
| **Trades** | Signal Listing | Complete | Matching | None | None |
| **Trades** | Take Trade | Complete | Matching | None | None |
| **Trades** | Create Trade | Incomplete | Broken | Levels key named `tradeLevels` (backend expects `levels`); `riskRewardRatio`, `slPips`, `tpPips` missing in request root | Change key in mobile payload to `levels` and populate `riskRewardRatio`, `slPips`, `tpPips` in the payload root |
| **Social** | Follow / Unfollow | Complete | Matching | None | Integrated follow/unfollow buttons in mobile leaderboard connected to follow APIs |
| **Payment** | Promo Coupons | Incomplete | Missing | Coupon code field and coupon verification service absent on mobile | Implement Coupon repository, apply/list coupon cubit flow, and coupon field in subscription page (reverted/removed from mobile scope) |
| **Subscription**| Plans Listing | Complete | Matching | None | None |
| **Subscription**| Plan Purchase | Incomplete | Mismatch | Reverted/Removed from mobile scope; checkout continues via Match2Pay Web gateway | None |
| **Subscription**| In-App Purchase | Missing | Backend Gap | Mobile In-App Purchases (IAP) bypass Match2Pay; Backend lacks receipt verification APIs | Implement a new backend verification controller (e.g. `/api/subscriptions/verify-iap`) to process App Store & Google Play receipts |

---

## 2. Trader Feature Audit

### Web Capabilities
- **Create Trade Signal:** Detailed form with entry price, Stop Loss (SL), up to 3 Take Profit (TP) levels, risk-to-reward (R:R) ratio, TradingView chart URL, and setup note.
- **My Trades:** Manage and monitor active and closed personal signals with status filters, date range picks, and pagination.
- **Client Tracking:** View list of clients who joined/took each trade signal.
- **Real-Time Price Updates:** Active charts/price updates via WebSocket connection.

### Mobile Alignment & Gaps
- **Create Trade (Broken):** The mobile screen is implemented but trade creation fails because the JSON body payload key is sent as `tradeLevels`, whereas the backend expects `levels`. Root parameters `riskRewardRatio`, `slPips`, and `tpPips` are also missing.
- **Real-time Price Subscription:** Symbol mapping normalizes slashed symbols (e.g., `EUR/USD` $\rightarrow$ `EURUSD`), matching the backend's topic subscription scheme.

---

## 3. Client Feature Audit

### Web Capabilities
- **Trading Signal Intake:** View signals tailored to active subscription category (Crypto, Forex, Elite).
- **Take Trade:** Join a trade, which tracks execution under the client's taken trades.
- **Leaderboard Interactions:** Browse high-performing traders, view detailed stats, and follow/unfollow them to filter setups.
- **Discount Coupons:** Apply promotional codes to get discounts on subscription checkouts.
- **Dashboard Stats:** Overview grid containing total trades, winning trades, win rate, and total profitability.

### Mobile Alignment & Gaps
- **Trader Following (Completed):** Integrated dynamic follow/unfollow buttons in the leaderboard for client users. The buttons call backend `FollowController` POST/DELETE endpoints and update status reactively.
- **Coupon System (Removed):** Reverted/removed from mobile client scope; subscriptions bypass native mobile coupons.
- **Dashboard Statistics:** The mobile client successfully loads user dashboard widgets but defaults to calling client metrics for traders, which could cause dashboard stat discrepancies for trader profiles.

---

## 4. API Comparison & Verification

### Authentication & Profiles
- Both web and mobile use `Authorization: Bearer <accessToken>` headers.
- Profile editing and picture uploads utilize multipart Form-Data matching.

### Trade Level Creation Mismatch
- Web sends:
  ```json
  {
    "market": "FOREX",
    "marketType": "BUY_LIMIT",
    "currencyPairId": 1,
    "note": "Note",
    "tradingViewUrl": "...",
    "riskRewardRatio": "1:2",
    "slPips": 50.0,
    "tpPips": 100.0,
    "levels": [
      {
        "levelType": "ENTRY",
        "entryPoint": 1.0850,
        "stopLoss": 1.0800,
        "level": 0
      }
    ]
  }
  ```
- Mobile sends:
  ```json
  {
    "market": "FOREX",
    "marketType": "BUY_LIMIT",
    "currencyPairId": 1,
    "note": "Note",
    "tradingViewUrl": "...",
    "tradeLevels": [ // Error: Should be "levels"
      {
        "levelType": "ENTRY",
        "entryPoint": 1.0850,
        "stopLoss": 1.0800,
        "level": 0
      }
    ]
  }
  ```
*(Missing: `riskRewardRatio`, `slPips`, `tpPips` in mobile request payload root)*

---

## 5. Subscription & In-App Purchase API Audit

### Existing Web Checkout Flow
1. User selects a plan $\rightarrow$ Calls `POST /api/match2pay/subscribe`.
2. Backend creates a pending Subscription record and generates a cryptocurrency payment checkout URL via Match2Pay gateway.
3. Match2Pay redirects the client to the payment page. Once paid, a webhook callback hits `/api/match2pay/callback`, which verifies signature and activates the user.

### Native In-App Purchase (IAP) Requirements
Integrating App Store (StoreKit) and Google Play Billing requires bypassing Match2Pay:
- **Receipt Validation Endpoint:** The backend needs a new controller `POST /api/subscriptions/verify-iap` accepting store purchase receipts/tokens.
- **IAP Plans Mapping:** Store product IDs (e.g. `crypto_monthly_99`) must be mapped to backend Plan entities.
- **Webhook Listeners:** Backend needs server-to-server notifications from Apple/Google to handle recurring renewals, cancellations, and expired subscriptions automatically.

---

## 6. Priority Action Items

### P0 – Critical (Fix Immediately)
- [ ] **Trader Trade Creation:** Map `'tradeLevels'` to `'levels'` and add missing root keys (`riskRewardRatio`, `slPips`, `tpPips`) in `AddTradeCubit`.

### P1 – High (Requires Backend Changes)
- [ ] **In-App Purchase (IAP) receipt verification API:** Create a new REST endpoint on the Spring Boot backend to validate Google Play and App Store receipts natively.

### P2 – Medium (Feature Gap Alignment)
- [x] **Follow/Unfollow Trader Flow:** Add buttons and integrate `/api/client/{traderPublicId}/follow` & `/unfollow` on mobile.

### P3 – Low (UX Polish)
- [ ] **Trader Dashboard statistics:** Ensure `HomeRepository` routes to `Apis.traderDashboard` statistics for users registered as Traders.
