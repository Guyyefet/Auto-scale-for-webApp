import { check } from "k6";
import http from "k6/http";
import { sleep } from 'k6';

export const options = {
  stages: [
    { duration: '3m', target: 50 },
    { duration: '2m', target: 50 },
    { duration: '2m', target: 500 },
    { duration: '2m', target: 500 },
    { duration: '2m', target: 1000 },
    { duration: '2m', target: 1000 },
    { duration: '2m', target: 1300 },
    { duration: '2m', target: 1300 },
    { duration: '2m', target: 500 },
    { duration: '2m', target: 500 },
    { duration: '8m', target: 0 },
  ],
  thresholds: {
    http_req_failed: ['rate<0.01'], // http errors should be less than 1%
    http_req_duration: ['p(95)<500'], // 95 percent of response times must be below 500ms
  },
};

export default function() {
  const res = http.get("http://3.88.54.161:8080/dummy");
  check(res, {
    "is status 200": (r) => r.status === 200
  });
  sleep(1);
};

