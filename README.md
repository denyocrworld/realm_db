### Realm DB
A class to make it easier to use Realm in Flutter.
Under Development.
Currently only available for disconnected mode.

---

### Install Package
```
flutter pub add realm_db
```

#### Initialize
```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();
  runApp(const MyApp());
}
```
#### Get Data
```
DB.instance.get<Product>(
    query: "",
    arguments: [],
) as RealmResults<Product>
```

#### Get Snapshot
```
DB.instance.snapshot<Product>(
    query: query,
    arguments: arguments,
)
```

#### Create
```
DB.instance.add<Product>(item)
```

#### Update
```
DB.instance.update<Product>(item, (current, item) {
    current.productName = item.productName;
    current.price = item.price;
})
```

#### Delete
```
DB.instance.delete<Product>(item);
```

#### Delete All
```
DB.instance.deleteAll<Product>();
```

### Auth
---
#### Login
```
await AuthService.instance.login(
    email: "admin@demo.com",
    password: "123456",
);
```
#### Logout
```
await AuthService.instance.logout();
```

#### Check Login Status
```
await AuthService.instance.isLoggedIn();
```

#### Register
```
await AuthService.instance.register(
    email: "admin@demo.com",
    password: "123456",
);
```