## 📦 Microservices Architecture Breakdown – DeathStarBench Social Network

The DeathStarBench Social Network benchmark is composed of numerous microservices, each fulfilling a specific function within the social network platform. Below is a categorized breakdown:

---

### 🧩 Core Microservices

| Service Name              | Description |
|---------------------------|-------------|
| `UserService`             | Manages user registration, authentication, and profiles. |
| `UserTimelineService`     | Manages the user's personal timeline (posts from themselves). |
| `HomeTimelineService`     | Aggregates posts from followed users into the user's home feed. |
| `ComposePostService`      | Coordinates the creation of a new post across services. |
| `PostStorageService`      | Stores posts and metadata persistently. |
| `MediaService`            | Handles image/video uploads and storage. |
| `TextService`             | Processes and formats text content. |
| `UserMentionService`      | Identifies and links @mentions in posts. |
| `UrlShortenService`       | Shortens URLs included in post content. |
| `UniqueIdService`         | Generates unique IDs for posts, users, etc. |
| `SocialGraphService`      | Manages relationships like follows and followers. |

---

### 💾 Supporting Services

| Category         | Service Name(s)                                 | Role |
|------------------|--------------------------------------------------|------|
| **Databases**    | `MongoDB` instances                             | Persistent storage for user, post, media, social graph data. |
| **Caching**      | `Redis`, `Memcached`                            | Speed up access to frequently requested data. |
| **Frontend**     | `media-frontend`, `nginx-thrift`                | Web UI and HTTP request routing. |
| **Observability**| `Jaeger`                                        | Distributed tracing for analyzing inter-service communication. |

---
### 🔁 Typical Request Flow: Compose a Post
1. User hits frontend (`nginx-thrift`) with a Compose request.
2. `ComposePostService`:
 - Calls `TextService` to process the text.
 - Calls `MediaService` if an image/video is attached.
 - Calls `UrlShortenService` to shorten any included links.
 - Calls `UserMentionService` to parse and link any @mentions.
 - Calls `UniqueIdService` to assign a new post ID.
 - Stores the final post in `PostStorageService`.
 - Updates `UserTimelineService` and `HomeTimelineService`.

---
### 📦 Technologies Used per 

| Layer             | Services                     | Technologies |
|-------------------|------------------------------|--------------|
| **API Gateway**   | `nginx-thrift`               | OpenResty (Nginx + Lua). |
| **Business Logic**| `~12 core services`          | Go, C++, Java, Python. |
| **Database**      | `MongoDB, Redis, Memcached`  | Storage and Caching. |
| **Observability** | `Jaeger`                     | Distributed Tracing. |
| **Load Gen**      | `wrk2`                       | LuaJIT-based HTTP load testing tool. |

---

### 🔁 Service Interactions Overview


- `ComposePostService` orchestrates the workflow for new posts.
- Posts are stored via `PostStorageService`.
- Timelines are updated via `UserTimelineService` and `HomeTimelineService`.
- All services interact with their respective Redis/Mongo/Memcached instances.
- Jaeger is used to trace these service calls and monitor latency.

---

### 🌐 Access Points

- **Nginx Frontend**: `http://localhost:8080`
- **Media Frontend**: `http://localhost:8081`
- **Jaeger UI**: `http://localhost:16686`

---

This architecture supports distributed, scalable, and modular deployment of a social networking platform, making it ideal for microservices benchmarking and performance analysis.
