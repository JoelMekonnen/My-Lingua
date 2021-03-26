from rest_framework import permissions
from .models import Student,Content,Takes
class ReadOnlyOrIsAdmin(permissions.BasePermission):
    def has_permission(self,request,view):
        if request.method in permissions.SAFE_METHODS:
            return True
        return request.user.is_staff
class UserPermission(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.method=='PUT':
            return obj.id==request.user.id
        return obj.id==request.user.id or request.user.is_staff
class ContentPermission(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.user.is_instructor:
            return True 
        elif request.method in permissions.SAFE_METHODS:
            if obj.id==1:
                return True
            try:
                return Takes.objects.get(userId=request.user.id,contentId=obj.id-1).isComplete
            except Exception:
                return False
        return False
class ReadOnly(permissions.BasePermission):
    def has_object_permission(self,request,view,obj):
        if request.user.is_staff or obj.id==request.user.certId.id or obj.id==request.user.gradeId.id:
            if request.method in permissions.SAFE_METHODS:
                return True
        return False
class ReadOnlyOrIsInstructor(permissions.BasePermission):
    def has_permission(self,request,view):
        if request.method in permissions.SAFE_METHODS:
            return True
        try:
            return request.user.is_instructor
        except Exception:
            return None