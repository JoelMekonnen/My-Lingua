# Generated by Django 3.1.7 on 2021-03-07 15:19

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('adminApp', '0004_auto_20210307_1214'),
        ('language_app', '0004_course_courseimage'),
    ]

    operations = [
        migrations.AddField(
            model_name='course',
            name='instructor',
            field=models.ForeignKey(default='', on_delete=django.db.models.deletion.CASCADE, related_name='course', to='adminApp.instructor'),
        ),
    ]