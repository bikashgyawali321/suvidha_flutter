import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';

class GetServiceKey {
  Future<String> GetServiceKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/firebase.database',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "suvidha-2901f",
          "private_key_id": "452cd17f3adb57603542ea3aaf54214e45fd751b",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC84lQxMhx87iud\nj03pL9tNLDg4xPy/rh9518m2g+gZO+oL77ZMZlbJDZMYSeQNEDLXHAq3GeMaTeUH\nkP7IXYqWe0G9eyK4h9f7nPCSfdDsUBHeXXrM6JK0HxqPfPO61CmeVDqQYEWv2ytG\nW/aul8P1YNl8ivhZwU8bQdpFaPuXFXHQfpmlrrz1sT7MeUpV/ckmkruerWnLEWxf\nCnPFNPsClwQ9xxuYIq2IPzudRROQhgzKjgrq4Pp/7cMsDfdwlcp34mGyXesoY5pL\nACb7kTGbx3Trkatl1+T1/qxqffkfE1+a9qjHM/qTpV4WowRyC70NdtM2F6TupeqZ\ns5eP1t4vAgMBAAECggEACTE3JNpXwScAbYiQI4jIaW3q6xqkPtogfpgU/Lbqq9+2\nS1lGS+2Lp7AQAWgHLXpuVdSCG0aGYyrCKBT3zLkQrmqxxlfFMjwaM58kgFyXty0B\n0ZzZTxXfC5R2yiji3fUQK7weN8yFV7ArKPrae1eTdYcQzojV/wFhFsGk0ykT7o1v\nV/ffJi6LX7ZPsg+zCQ/kgYgtslVnuayOFY+BJmTEQLHUFXetmrDw2iUKQsZcegOw\nMua9UYNnvVTHFBzxEWxT0vjorHomA581NONkkbRGBssZPPTMiZ/VDvG9Ls3hUZQP\nED/aHJkjRy4UWWlkX+menspD1MYP4TdvTTxd2S+i8QKBgQD4TGkNEdTxv60EQ5Fx\nJWrCTp7re1tRnr3mSr7yHa2RWO21aGJ4wvalnb4w41a9BAt/GOSQ8A7wctt8r5BR\nQeFSPQBy9ZOFmHxRHnwEFq8Og32l4ONz9tQANJkACnQcc1oIg6oMenjilgFYQdxp\ns5W1TvarBeqHC3LWtbXoV9/inQKBgQDCviT8Ki13O6kMkf1i1zjX5nW4lzQ1R7Vl\n2WnQBjnBhB0aPHMip2xHmvVe82WUmRQeNzd7eRmJBG4WtuBZa28W2CS3+iOQ+DgI\n7l2hMHLL6PqqLyQQQNJTnpzc1ar0rdxgQypL/5lSz6ScZ1Cb4K1qkzN3IbDzkL3w\n0XcBFED0OwKBgD/wDS0cZmVKIldyvsUQCYm3jRy+SymdYvEmVj0qf0NqTuvj0Vef\nfLvw/sTABdnubLdxxYm9B1vLd9GHs/X4rPjsVG1F55MDTR/mZbD31mQ6X+STIH8A\nFF9pK+zixDt/SLPgk61a7D4MupPrgcKGSArEJqirgVT9EblQWWNXHYPRAoGANf64\njH45SvTsw0J7KfuYlCwe+cZawGcYgZvNfdMsEl7KHush1Trsh9IMNH5x7Migzlvq\n8z45eUcUKxIblE94ZrIZRDWDxP89siQ9K6MeQTFgxuz5J9SBPJQe1BAeLWdDUiFt\nSdMdtNtDveXbcMzT6FfWDjL2OCIqt+msAE2YUN8CgYBTtmA85S1sP3AMa18bKrva\n4hbXzo6PoPl1OJeD3LU1zZNm5BIH/G3dvkJ0aT5AxiJjR5jaBlty8An/FyD/yFeG\nGU/ryQ44zLej+TphC9tWkH+0G/a7PJEN3fqQvDx+/J03UYDFN45rqzfmg9HWnRyV\n8+CTRRDoCREbKTDR0FMpQQ==\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-53t3d@suvidha-2901f.iam.gserviceaccount.com",
          "client_id": "101623154904918939043",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-53t3d%40suvidha-2901f.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}
