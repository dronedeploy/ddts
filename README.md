# ddts

A style guide for writing better typescript, enforced via tslint pre-commit hook.

## Enforced Rules

### [Alignment](https://palantir.github.io/tslint/rules/align/)

Function parameters and arguments should be on the same line until they surpass the max line length(80), at which point they should be aligned vertically each on their own line.
```ts
// BAD
const bar = (a,
  b,
c) => {
  ...
};

// GOOD
const bar = (a, b, c) => {
  ...
};

// BAD                                 having to scroll horizontally is shitty
const foo = (parameter, otherReallyLongParameter, superDuperLongParameter, tooManyParametersForOneLine) => {
  ...
};

// GOOD
const foo = (
  parameter,
  otherReallyLongParameter,
  superDuperLongParameter,
  tooManyParametersForOneLine
) => {
  ...
};
```

### [Arrow Function Parentheses](https://palantir.github.io/tslint/rules/arrow-parens/)

Always use parentheses around arrow function parameters, for consistency.
```ts
// BAD
const foo = x => x*x;
const lesserThings = things.map(thing => thing - 1);

// GOOD
const foo = (x) => x*x;
const lesserThings = things.map((thing) => thing -1);
```

### [Class and Interface Names](https://palantir.github.io/tslint/rules/class-name/)

Class and Interface names should always be pascal-case for ease of identification.
```ts
// BAD
interface user {
  ...
}
class accountInfo {
  ...
}

// GOOD
interface User {
  ...
}
class AccountInfo {
  ...
}
```

### [Single-line Comments](https://palantir.github.io/tslint/rules/comment-format/)

There should be a space between the `//` and the first word.
```ts
//not a GOOD
//reading experience

// a better
// reading experience
```

### [Conditional Curly Braces](https://palantir.github.io/tslint/rules/curly/)

Curly braces should always be used for `if/for/do/while` statements for clarity on what is included in the statement.
```ts
// BAD
if(thing < other)
  thing++;
  return thing;
// it's unclear whether the author knows the return
// statement is not included in the conditional block

// GOOD
if(thing < other) {
  thing++;
  return thing;
}
// OR
if(thing < other) {
  thing++;
}
return thing;


// BAD
if(foo) return true;
// it's much easier to scan for return statements
// when 'return' is the left-most word on the line

// GOOD
if(foo) {
  return true;
}
```

### [End of File Newline](https://palantir.github.io/tslint/rules/eofline/)

End every file with a newline character, because otherwise it's [not a line](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206).

### [Indent With Spaces](https://palantir.github.io/tslint/rules/indent/)

Mixing tabs and spaces is insanity, and spaces are interpreted the same universally whereas tabs are not.

### [Interface Name Prefixing](https://palantir.github.io/tslint/rules/interface-name/)

Why mangle names to save time in differentiating an interface from a class when it's an arguably superfluous distinction in many cases.
```ts
// BAD
interface IIllusion { // kill me now please
  ...
}

// GOOD
interface Illusion {
  ...
}
```

### [Labels](https://palantir.github.io/tslint/rules/label-position/)

Labels only belong in `do/for/while/switch` statements, if at all.
```ts
// BAD
happy:
if(true) {
  console.log('happy days');
  if(condition) {
    break happy;
  }
}


// ACCEPTABLE, albeit contrived
let i = 0;
let j = 0;

loop1:
for (i = 0; i < 3; i++) {
   loop2:
   for (j = 0; j < 3; j++) {
      if (i === 1 && j === 1) {
         break loop1;
      }
      console.log(`i = ${i}, j = ${j}`);
   }
}
```

### [One Class Per File](https://palantir.github.io/tslint/rules/max-classes-per-file/)

Classes deserve their own files (which should be named after them).
```ts
// BAD
/* in file 'hurdydurr.ts' */
class Foo {
  ...
}
class Bar {
  ...
}


// GOOD
/* in file 'foo.ts' */
class Foo {
  ...
}

/* in file 'bar.ts' */
class Bar {
  ...
}
```
### [Class Member Ordering](https://palantir.github.io/tslint/rules/member-ordering/)

Order the members of a class consistently, for discoverability. Priority rules are:
1. fields
  1. static public
  2. static private
  3. public
  4. private
2. functions
  1. constructor
  2. static public
  3. static private
  4. public
  5. private

Members are public by default, so avoid clutter by omitting the designation.
```ts
class Alphabet {
  static a = true;
  static private b = false;

  c = true;
  private d = false;

  constructor() { //
    // ...
  }

  static e() {
    // ...
  }

  static private f() {
    // ...
  }

  g() {
    // ...
  }

  private h() {
    // ...
  }
}
```

### [New Parentheses](https://palantir.github.io/tslint/rules/new-parens/)

Use parentheses when invoking a constructor function with `new` for consistency with other function calls.
```ts
class Foo {
  ...
}

// BAD
const bad = new Foo;
// you'll have to use parentheses to pass arguments to other
// constructors, so use them all the time for consistency.

// GOOD
const good = new Foo();
```

### [No `arguments.callee` References](https://palantir.github.io/tslint/rules/no-arg/)

Using `arguments.callee` makes various performance optimizations impossible.
```ts
// BAD
[1, 2, 3, 4, 5].map(function(n) {
    return !(n > 1) ? 1 : arguments.callee(n - 1) * n;
});

// GOOD
const factorial = (n) => {
  return !(n > 1) ? 1 : factorial(n - 1) * n;
};

[1, 2, 3, 4, 5].map(factorial);
```
