from django import template
register = template.Library()
@register.simple_tag
def placeHolder(value, arg, classname):
    return value.as_widget(attrs={'placeholder':arg, 'class': classname})