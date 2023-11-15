### 注解属性

```lua
---@type(attr) number

--不能有空格，避免以下歧义

---@type (number)
```

### 多行注解的规则

* `---` 表示为注解，注释请用 `--` 。
* 作为部分兼容措施，最先出现的 `---` 被识别为 `--`。

```lua
---注释
---@class A
---不能作为字段注释
--这才是字段注释
---@field getX fun()
---: number
---@field x number
```

被解释为：

```lua
--注释
---@class A --不能作为字段注释
--这才是字段注释
---@field getX fun(): number
---@field x number
```
