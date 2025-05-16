- Define mixin with arguments
    - syntax

    `@mixin name($var,$var2){

        property: $var1;

        property: $var2;

    }`

 @mixin bordered($color, $width) {
  border: $width solid $color;
}

.myArticle {
  @include bordered(blue, 1px);  // Call mixin with two values
}

.myNotes {
  @include bordered(red, 2px); // Call mixin with two values
} 