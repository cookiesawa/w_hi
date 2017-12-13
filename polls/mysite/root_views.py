# 루트 인덱스
from django.http import HttpResponse

def index(request):
  return HttpResponse("Hello 여기는 mysite 루트의 인덱스 페이지입니다.")
