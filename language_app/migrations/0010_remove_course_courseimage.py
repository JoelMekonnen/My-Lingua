# Generated by Django 3.1.7 on 2021-03-07 16:39

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('language_app', '0009_auto_20210307_1527'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='course',
            name='courseImage',
        ),
    ]
